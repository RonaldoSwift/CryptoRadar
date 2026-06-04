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

public struct CryptoListView: View {
    
    @StateObject private var viewModel: CryptoListViewModel
    
    public init(viewModel:CryptoListViewModel) {
        _viewModel = StateObject(wrappedValue:viewModel)
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
        }
    }
}

private extension CryptoListView {
    
    var header: some View {
        
        HStack {
            Text("Search Assets")
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
            "Search assets...",
            text: .constant("")
        )
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .foregroundColor(.white)
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
                
                Button("Retry") {
                    viewModel.loadCryptos()
                }
            }
            
        } else {
            ScrollView {
                LazyVStack(spacing: 14) {
                    
                    ForEach(viewModel.cryptos) { crypto in
                        CryptoCard(crypto:crypto)
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
                repository:
                    MockCryptoRepository()
            )
    )
}
