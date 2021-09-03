//
//  ListFavoriteRowView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 23/08/21.
//

import SwiftUI
import Kingfisher

struct ListFavoriteRow: View {
    let favorite: GameFavorite
    
    var body: some View {
        HStack {
            KFImage(URL(string: favorite.gameBacground ?? ""))
                .resizable()
                .loadImmediately()
                .frame(width: 100, height: 80, alignment: .top)
            VStack(alignment: .leading) {
                Text(favorite.gameName ?? "")
                    .font(.headline)
                Text(favorite.gameRelease ?? "")
                    .foregroundColor(.secondary)
                HStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(ColorManager.accentColor)
                    Text("\(String(format: "%.2f", favorite.gameRating))")
                        .foregroundColor(.secondary)
                }
               
            }
        }
    }
}
