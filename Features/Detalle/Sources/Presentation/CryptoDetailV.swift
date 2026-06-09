//
//  CryptoDetailV.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 9/06/26.
//

import SwiftUI

public struct CryptoDetailV: View {
    
    @StateObject private var viewModel: CryptoDetailViewModel
    private let cryptoId: String
    
    public init(cryptoId: String,viewModel: CryptoDetailViewModel) {
        self.cryptoId = cryptoId
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

private extension CryptoDetailV {
    @ViewBuilder var content: some View {
        
        if viewModel.isLoading {
            ProgressView()
                .tint(.white)
            
        } else if let error = viewModel.errorMessage {
            Text(error)
                .foregroundColor(.white)
            
        } else if let crypto = viewModel.crypto {
            
            ScrollView {
                VStack(spacing: 24) {
                    header(crypto: crypto)
                    priceSection(crypto: crypto)
                    chartView
                    statsSection(crypto: crypto)
                    descriptionSection(crypto: crypto)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func header(crypto: CryptoDetail) -> some View {
        
        HStack {
            Text(crypto.name)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite()
            } label: {
                Image(systemName: crypto.isFavorite ? "star.fill" : "star")
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
                Text("Graph")
                    .foregroundColor(.gray)
            }
    }
    
    @ViewBuilder
    func statsSection(crypto: CryptoDetail) -> some View {
        
        VStack(alignment: .leading,spacing: 16) {
            
            Text("Statistics")
                .foregroundColor(.white)
                .bold()
            
            LazyVGrid(
                columns: [
                    GridItem(),
                    GridItem()
                ]
            ) {
                statCard(title: "Price",value:"$\(crypto.currentPrice,default: "%.2f")")
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
            
            Button(viewModel.showFullDescription ? "Read less" : "Read more") {
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
    CryptoDetailV(
        cryptoId: "bitcoin",
        viewModel:
            CryptoDetailViewModel(
                repository: MockCryptoDetailRepository()
            )
    )
}
