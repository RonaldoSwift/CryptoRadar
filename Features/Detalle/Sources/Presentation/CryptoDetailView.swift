//
//  CryptoDetailV.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import SwiftUI
import Favorite

public struct CryptoDetailView: View {
    
    @StateObject private var viewModel: CryptoDetailViewModel
    private let cryptoId: String
    private let cryptoName: String
    
    public init(cryptoId: String,cryptoName: String,viewModel: CryptoDetailViewModel) {
        self.cryptoId = cryptoId
        self.cryptoName = cryptoName
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            content
        }
        .task {
            viewModel.load(id: cryptoId)
        }
    }
}

private extension CryptoDetailView {
    @ViewBuilder
    var content: some View {
        
        ScrollView {
            
            VStack(spacing: 24) {
                
                // Este aparece siempre
                header(crypto: viewModel.crypto)
                
                if viewModel.isLoading {
                    
                    ProgressView()
                        .tint(.white)
                    
                } else if let crypto = viewModel.crypto {
                    
                    priceSection(crypto: crypto)
                    chartView
                    statsSection(crypto: crypto)
                    descriptionSection(crypto: crypto)
                    
                } else if let error = viewModel.errorMessage {
                    
                    Text(error)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func header(crypto: CryptoDetail?) -> some View {
        
        HStack {
            Text(crypto?.name ?? cryptoName)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(
                    systemName: (crypto?.isFavorite ?? false) ? "star.fill": "star"
                )
                .foregroundColor(.yellow)
            }
        }
    }
    
    @ViewBuilder
    func priceSection(crypto: CryptoDetail) -> some View {
        VStack(spacing: 8) {
            Text(CryptoDetailStrings.currentPrice)
                .foregroundColor(.gray)
            
            Text("$\(crypto.currentPrice,specifier: "%.2f")")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }
    }
    
    var chartView: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white.opacity(0.05))
            .frame(height: 220)
            .overlay {
                Text(CryptoDetailStrings.graph)
                    .foregroundColor(.gray)
            }
    }
    
    @ViewBuilder
    func statsSection(crypto: CryptoDetail) -> some View {
        
        VStack(alignment: .leading,spacing: 16) {
            
            Text(CryptoDetailStrings.statistics)
                .foregroundColor(.white)
                .bold()
            
            LazyVGrid(
                columns: [
                    GridItem(),
                    GridItem()
                ]
            ) {
                statCard(
                    title: "Price",
                    value: String(
                        format: "$%.2f",
                        crypto.currentPrice
                    )
                )
                statCard(title: "ID",value: crypto.id)
            }
        }
    }
    
    @ViewBuilder
    func statCard(title: String,value: String) -> some View {
        VStack(alignment: .leading,spacing: 8) {
            Text(title)
                .foregroundColor(.gray)
            
            Text(value)
                .foregroundColor(.white)
                .bold()
        }
        .frame(maxWidth: .infinity,minHeight: 120)
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
    }
    
    @ViewBuilder
    func descriptionSection(crypto: CryptoDetail) -> some View {
        
        VStack(alignment: .leading,spacing: 12
        ) {
            Text("About \(crypto.name)")
                .foregroundColor(.white)    
                .bold()
            
            Text(
                viewModel.showFullDescription ? crypto.description : String(crypto.description.prefix(250))
            )
            .foregroundColor(.gray)
            
            Button(viewModel.showFullDescription ? CryptoDetailStrings.readLess : CryptoDetailStrings.readMore) {
                viewModel.toggleDescription()
            }
            .foregroundColor(.blue)
        }
        
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
    }
}

#Preview {
    CryptoDetailView(
        cryptoId: "bitcoin", cryptoName: "",
        viewModel:
            CryptoDetailViewModel(
                repository: MockCryptoDetailRepository(),
                favoriteRepository: MockFavoriteRepository()
            ),
    )
}
