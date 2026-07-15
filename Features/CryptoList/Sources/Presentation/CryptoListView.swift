//
//  CryptoListView.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

//
//  CryptoHomeView.swift
//

import SwiftUI
import CryptoList
import Favorite

public struct CryptoListView: View {
    
    @StateObject private var viewModel: CryptoListViewModel
    private let onTapCrypto: (String) -> Void
    @ObservedObject private var favoriteViewModel: FavoriteListViewModel
    
    public init(viewModel:CryptoListViewModel,favoriteViewModel:FavoriteListViewModel,onTapCrypto:@escaping (String) -> Void) {
        _viewModel = StateObject(wrappedValue:viewModel)
        self.favoriteViewModel = favoriteViewModel
        self.onTapCrypto = onTapCrypto
    }
    
    public var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                header
                searchBar
                trending
                content
                Spacer()
            }
            .padding()
        }
        .task {
            viewModel.loadCryptos()
            favoriteViewModel.load()
        }
    }
}

private extension CryptoListView {
    
    var header: some View {
        
        HStack {
            Text(CryptoListStrings.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
            
            Image(
                systemName:"slider.horizontal.3"
            )
            .foregroundColor(.white)
        }
    }
    
    var searchBar: some View {
        
        TextField(
            CryptoListStrings.searchPlaceholder,
            text: $viewModel.searchText
        )
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .foregroundColor(.white)
        .onChange(of: viewModel.searchText) { _ in
            viewModel.searchCryptos()
        }
    }
    
    var trending: some View {
        
        ScrollView(.horizontal,showsIndicators:false) {
            
            HStack {
                ForEach(
                    ["Bitcoin","Ethereum","Solana","Polkadot"],
                    id: \.self
                ) { item in
                    Text(item)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
                .tint(.white)
            
            Spacer()
        } else if let error = viewModel.errorMessage {
            
            VStack(spacing: 16) {
                
                Text(error)
                    .foregroundColor(.white)
                
                Button(CryptoListStrings.retry) {
                    viewModel.loadCryptos()
                }
            }
            
        } else {
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(viewModel.cryptos) { crypto in
                        CryptoCardView(
                            crypto: crypto,
                            isFavorite: favoriteViewModel.isFavorite(id: crypto.id)
                        ) {
                            favoriteViewModel
                                .toggleFavorite(
                                    FavoriteCrypto(
                                        id:crypto.id,
                                        name:crypto.name,
                                        symbol:crypto.symbol,
                                        image:crypto.image,
                                        currentPrice:crypto.currentPrice
                                    )
                                )
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onTapCrypto(crypto.id)
                        }
                    }
                }
            }
            .refreshable { await viewModel.refresh()
            }
        }
    }
}

#Preview {
    CryptoListView(
        viewModel:
            CryptoListViewModel(
                repository: MockCryptoRepository()
            ),
        
        favoriteViewModel:
            FavoriteListViewModel(
                repository: MockFavoriteRepository())
    ) { _ in }
}
