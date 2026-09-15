//
//  BannerViewModel.swift
//  LLVod
//
//  Created by minusapple on 2026/7/13.
//

import Foundation
import Combine

@MainActor
final class BannerViewModel: ObservableObject {

    @Published private(set) var bannerData: [VideoItem] = []

    @Published private(set) var listData: [VideoItem] = []

    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private var hasLoaded = false
    private var lastURL = ""

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadIfNeeded(_ urlString: String) async {
        if hasLoaded, lastURL == urlString, !bannerData.isEmpty || !listData.isEmpty {
            return
        }
        await getBanner(urlString, force: false)
    }

    func getBanner(_ urlString: String) async {
        await getBanner(urlString, force: true)
    }

    private func getBanner(_ urlString: String, force: Bool) async {
        if !force, hasLoaded, lastURL == urlString { return }
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        let result = await ahDetachedResult {
            try await self.fetchBannerWithFallback(urlString)
        }
        isLoading = false

        switch result {
        case .failure(let error):
            if error is CancellationError { return }
            if let urlError = error as? URLError, urlError.code == .cancelled { return }
            errorMessage = error.localizedDescription
            
        case .success(let page):
            bannerData = page.banner
            listData = page.list
            lastURL = urlString
            hasLoaded = true
        }
    }

    private func fetchBannerWithFallback(
        _ urlString: String
    ) async throws -> (banner: [VideoItem], list: [VideoItem]) {
        do {
            return try await requestBanner(urlString)
        } catch {
            /*
             保留 Flutter 逻辑：
             当前地址不是备用地址时，改为请求备用地址；
             当前已经是备用地址时，不再重复请求。
             */
            guard urlString != "https://login.yiys06.com/zy.json" else { throw error }
            return try await requestBanner("https://login.yiys06.com/zy.json")
        }
    }

    private func requestBanner(
        _ urlString: String
    ) async throws -> (
        banner: [VideoItem],
        list: [VideoItem]
    ) {
        guard let url = URL(string: urlString) else {
            throw BannerRequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20

        request.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Accept"
        )

        /*
         Flutter 原代码写的是 Content-Encoding: gzip。

         Content-Encoding 通常表示请求体经过 gzip 编码，
         GET 请求没有请求体，因此不建议这样设置。

         客户端希望服务器返回 gzip 时，应使用 Accept-Encoding。
         */
        request.setValue(
            "gzip, deflate",
            forHTTPHeaderField: "Accept-Encoding"
        )

        let (data, response) = try await session.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw BannerRequestError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw BannerRequestError.httpError(
                httpResponse.statusCode
            )
        }

        guard !data.isEmpty else {
            throw BannerRequestError.emptyData
        }

        guard var encryptedText = String(
            data: data,
            encoding: .utf8
        ) else {
            throw BannerRequestError.emptyResponseText
        }

        encryptedText = filterNewlines(encryptedText)

        let decryptedJSON = try CryptoUtil.aesDecryptECB(
            encryptedText,
            key: "ahsp123456789012"
        )

        guard let jsonData = decryptedJSON.data(
            using: .utf8
        ) else {
            throw BannerRequestError.invalidJSON
        }

        do {
            let responseModel = try JSONDecoder().decode(
                BannerAPIResponse.self,
                from: jsonData
            )

            return convertResponse(responseModel)
        } catch {
             throw BannerRequestError.invalidJSON
        }
    }

    private func convertResponse(
        _ response: BannerAPIResponse
    ) -> (
        banner: [VideoItem],
        list: [VideoItem]
    ) {
        var banners: [VideoItem] = []
        var videos: [VideoItem] = []

        for category in response.list {
            switch category.typeID {
            case 0:
                let mappedItems = category.videoList.map { item in
                    let videoID = item.videoID?.stringValue ?? ""

                    return VideoItem(
                        id: makeStableID(
                            videoID: videoID,
                            name: item.videoName ?? ""
                        ),
                        name: item.videoName ?? "",
                        pictureURL: item.videoPicture ?? "",
                        remarks: item.videoRemarks ?? "",
                        extraValue: item.videoTimeAdd?.stringValue ?? "",
                        videoID: videoID
                    )
                }

                videos.append(contentsOf: mappedItems)

            case 1:
                let mappedItems = category.videoList.map { item in
                    let videoID = item.videoID?.stringValue ?? ""

                    return VideoItem(
                        id: makeStableID(
                            videoID: videoID,
                            name: item.videoName ?? ""
                        ),
                        name: item.videoName ?? "",
                        pictureURL: item.videoPicture ?? "",
                        remarks: item.videoRemarks ?? "",
                        extraValue: item.visibility?.stringValue ?? "",
                        videoID: videoID
                    )
                }

                banners.append(contentsOf: mappedItems)

            default:
                // 忽略其他 type_id
                break
            }
        }

        return (
            banner: banners,
            list: videos
        )
    }

    private func makeStableID(
        videoID: String,
        name: String
    ) -> String {
        if !videoID.isEmpty {
            return videoID
        }

        return "\(name)-\(UUID().uuidString)"
    }

    private func filterNewlines(
        _ text: String
    ) -> String {
        text
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
