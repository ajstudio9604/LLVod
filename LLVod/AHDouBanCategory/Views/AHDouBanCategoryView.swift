//
//  AHDouBanCategoryView.swift
//  LLVod
//
//  对应 Flutter pagev2.dart：片单分类 Tab + 分页列表
//

import SwiftUI
import SwiftUIPager

struct AHDouBanCategoryView: View {
    
    @StateObject private var vm = AHDouBanCategoryViewModel()
    @State private var selectedIndex = 0
    @State private var page = Page.withIndex(0)
    @State private var bottomInset: CGFloat = 0
    
    private var tabHeader: some View {
        let tabs = vm.tabs
        
        return ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                        Button {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                                page.update(.new(index: index))
                                proxy.scrollTo(tab.id, anchor: .center)
                            }
                        } label: {
                            VStack(spacing: 6) {
                                Text(tab.title)
                                    .font(.system(
                                        size: selectedIndex == index ? 15 : 13,
                                        weight: selectedIndex == index ? .bold : .regular
                                    ))
                                    .foregroundColor(
                                        selectedIndex == index ? .red : .gray
                                    )
                                
                                Capsule()
                                    .fill(selectedIndex == index ? .red : .clear)
                                    .frame(width: 16, height: 3)
                            }
                        }
                        .id(tab.id)
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                DispatchQueue.main.async {
                    if selectedIndex < tabs.count {
                        proxy.scrollTo(tabs[selectedIndex].id, anchor: .center)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                tabHeader
                
                Pager(
                    page: page,
                    data: vm.tabs,
                    id: \.id
                ) { tab in
                    AHDouBanPieceView(
                        viewModel: vm.pieceViewModel(for: tab),
                        bottomInset: contentBottomInset
                    )
                }
                .onPageChanged { index in
                    selectedIndex = index
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ahTabRootIgnoreBottomSafeAreaIfNeeded()
            .navigationTitle("片单")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ahTabRootBottomInsetProbe($bottomInset)
        .ahFixLayoutAfterRotation()
    }

    private var contentBottomInset: CGFloat {
        AHTabRootBottomLayout.contentBottomInset(measuredSafeAreaBottom: bottomInset)
    }
}

#Preview {
    AHDouBanCategoryView()
}
