//
//  SearchBatchRequestManager.swift
//  LLVod
//
//  对应 Flutter BatchRequestManager（RequestParams.dart）
//

import Foundation

actor SearchBatchRequestManager {

    private var isCancelled = false

    func cancelAll() {
        isCancelled = true
    }

    private func cancelled() -> Bool {
        isCancelled
    }

    func batchRequest(
        _ paramsList: [AHSearchRequestParams],
        maxConcurrency: Int = 5,
        onCompleted: @escaping @Sendable (AHSearchRequestResult) async -> Void
    ) async {
        let factories: [() async -> AHSearchRequestParams?] = paramsList.enumerated().map { index, params in
            {
                AHSearchRequestParams(
                    url: params.url,
                    method: params.method,
                    data: params.data,
                    headers: params.headers,
                    sourceIndex: params.sourceIndex ?? index
                )
            }
        }
        await batchRequestAsReady(factories, maxConcurrency: maxConcurrency, onCompleted: onCompleted)
    }

    func batchRequestAsReady(
        _ paramsFutures: [() async -> AHSearchRequestParams?],
        maxConcurrency: Int = 5,
        onCompleted: @escaping @Sendable (AHSearchRequestResult) async -> Void
    ) async {
        isCancelled = false
        guard !paramsFutures.isEmpty else { return }

        let limit = max(1, maxConcurrency)
        let gate = AHSearchConcurrencyGate(limit: limit)

        await withTaskGroup(of: Void.self) { group in
            for (index, factory) in paramsFutures.enumerated() {
                group.addTask {
                    guard await !self.cancelled() else { return }
                    guard let built = await factory() else { return }

                    let params = AHSearchRequestParams(
                        url: built.url,
                        method: built.method,
                        data: built.data,
                        headers: built.headers,
                        sourceIndex: built.sourceIndex ?? index
                    )

                    await gate.wait()
                    guard await !self.cancelled() else {
                        await gate.signal()
                        return
                    }

                    let result = await Self.executeRequest(
                        params,
                        fallbackIndex: params.sourceIndex ?? index
                    )
                    await gate.signal()
                    await onCompleted(result)
                }
            }
        }
    }

    private static func executeRequest(
        _ params: AHSearchRequestParams,
        fallbackIndex: Int
    ) async -> AHSearchRequestResult {
        let index = params.sourceIndex ?? fallbackIndex
        let (response, networkError) = await SearchHTTPClient.batchRequest(
            method: params.method,
            urlString: params.url,
            body: params.data,
            headers: params.headers
        )

        if response.statusCode < 0 {
            return AHSearchRequestResult(
                index: index,
                data: nil,
                statusCode: nil,
                errorMessage: networkError ?? "network error",
                realURI: response.realURI
            )
        }

        if !(200...299).contains(response.statusCode) {
            return AHSearchRequestResult(
                index: index,
                data: response.body.isEmpty ? nil : response.body,
                statusCode: response.statusCode,
                errorMessage: "HTTP \(response.statusCode)",
                realURI: response.realURI
            )
        }

        return AHSearchRequestResult(
            index: index,
            data: response.body,
            statusCode: response.statusCode,
            errorMessage: nil,
            realURI: response.realURI
        )
    }
}

private actor AHSearchConcurrencyGate {
    private let limit: Int
    private var available: Int
    private var waiters: [CheckedContinuation<Void, Never>] = []

    init(limit: Int) {
        self.limit = limit
        self.available = limit
    }

    func wait() async {
        if available > 0 {
            available -= 1
            return
        }
        await withCheckedContinuation { continuation in
            waiters.append(continuation)
        }
    }

    func signal() {
        if let waiter = waiters.first {
            waiters.removeFirst()
            waiter.resume()
        } else {
            available = min(limit, available + 1)
        }
    }
}
