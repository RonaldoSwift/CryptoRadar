//
//  CryptoCard.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import SwiftUI

struct CryptoCardView: View {
    
    let crypto: Crypto
    let isFavorite: Bool
    let onTapFavorite: () -> Void
    
    var body: some View {
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
                    .foregroundColor(.white)
                    .bold()
                
                Text(crypto.symbol.uppercased())
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing,spacing: 8) {
                Button {
                    onTapFavorite()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                }
                .buttonStyle(.plain)

                Text(crypto.currentPrice.formatted(.currency(code: "USD")))
                .foregroundColor(.white)
                
                Text(
                    String(
                        format: "%.2f%%",
                        crypto.priceChangePercentage24h
                    )
                )
                .foregroundColor(crypto.priceChangePercentage24h >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(18)
    }
}
