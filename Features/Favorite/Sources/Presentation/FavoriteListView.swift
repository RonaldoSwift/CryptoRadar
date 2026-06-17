//
//  FavoriteListView.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 12/06/26.
//

import SwiftUI
import CryptoList
import SwiftData

public struct FavoriteListView: View {
    
    @ObservedObject private var viewModel = FavoriteListViewModel()
    
    private let onTapCrypto: (String) -> Void
    
    @Environment(\.modelContext) private var context
    
    public init(viewModel:FavoriteListViewModel,onTapCrypto:@escaping (String)->Void) {
        self.viewModel = viewModel
        self.onTapCrypto = onTapCrypto
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                header
                searchBar
                content
                Spacer()
            }
            .padding()
        }
        .task {
            viewModel.loadFavorites(context:context)
        }
    }
}

private extension FavoriteListView {
    
    var header: some View {
        
        HStack {
            Text(FavoriteStrings.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
        }
    }
    
    var searchBar: some View {
        
        TextField(FavoriteStrings.searchFavorite,text:$viewModel.searchText)
            .padding()
            .background(Color.white.opacity(0.06))
            .cornerRadius(14)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    var content: some View {
        
        if viewModel.filteredFavorites.isEmpty {
            
            VStack(spacing: 16) {
                Image(systemName:"star")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                Text(FavoriteStrings.empty)
                    .foregroundColor(.gray)
            }
            
        } else {
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(viewModel.filteredFavorites) { favorite in
                        favoriteCard(crypto:favorite)
                            .overlay(alignment:.trailing) {
                                Button {
                                    viewModel.removeFavorite(id:favorite.id, context: context)
                                } label: {
                                    Image(systemName:"star.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.trailing,16)
                                }
                                .buttonStyle(.plain)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onTapCrypto(favorite.id)
                            }
                    }
                }
            }
        }
    }
    
    func favoriteCard(crypto: FavoriteCrypto) -> some View {
        HStack(spacing: 14) {
            AsyncImage(url:URL(string:crypto.image)) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 46,height: 46)
            .clipShape(Circle())
            
            VStack(alignment:.leading) {
                Text(crypto.name)
                    .foregroundColor(.white).bold()
                
                Text(crypto.symbol.uppercased())
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(crypto.currentPrice.formatted(.currency(code:"USD")))
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(18)
    }
}

#Preview {
    
    FavoriteListView(
        viewModel: FavoriteListViewModel()
    ) { _ in }
}
