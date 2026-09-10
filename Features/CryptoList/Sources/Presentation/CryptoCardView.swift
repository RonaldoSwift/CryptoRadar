//
//  CryptoCard.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 4/06/26.
//

import SwiftUI
import ImageKit
import Favorite

struct CryptoCardView: View {
    
    let crypto: Crypto
    let isFavorite: Bool
    let onTapFavorite: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            CachedAsyncImage(url: crypto.image)
                .frame(width: 46, height: 46)
                .clipShape(Circle())
            
            VStack(alignment:.leading) {
                Text(crypto.name)
                    .foregroundStyle(.primary)
                    .bold()
                
                Text(crypto.symbol.uppercased())
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing,spacing: 8) {
                FavoriteHeartButton(isFavorite: isFavorite, size: 20) {
                    onTapFavorite()
                }
            }
        }
        .padding()
        .background(Color.primary.opacity(0.05))
        .cornerRadius(18)
    }
}
