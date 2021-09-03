//
//  ListFavoriteDetailView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 23/08/21.
//

import SwiftUI
import Kingfisher

struct FavoriteDetailView: View {
    @Environment(\.managedObjectContext) private var mOC
    @Environment(\.presentationMode) var presentationMode
    
    let favorite: GameFavorite
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor.ignoresSafeArea(edges: .all)
            Group {
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                        
                        KFImage(URL(string: favorite.gameBacground ?? ""))
                            .resizable()
                            .loadImmediately()
                            .frame(height: 350)
                            .modifier(ImageDetailModifier())
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 2) {
                                Text("\(String(format: "%.2f", favorite.gameRating))")
                                    .font(.system(size: 12, weight: .bold, design: .default))
                                    .foregroundColor(ColorManager.primaryTextColor)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(ColorManager.primaryColor)
                                
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.all, 4)
                            .frame(width: 70, height: 30)
                            .background(Rectangle().fill(ColorManager.accentColor).cornerRadius(20))
                            
                            Text(favorite.gameName ?? "")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(ColorManager.primaryTextColor)
                            
                            Text(favorite.gameRelease ?? "")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(ColorManager.secondaryTextColor)
                                .padding(.top, 1)
                            
                            Text(favorite.gameDescription ?? "")
                                .font(.system(size: 14, weight: .light, design: .default))
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        
                    })
                    .ignoresSafeArea(edges: .all)
                    .background(ColorManager.backgroundColor)
            }
        }

        .navigationBarItems(trailing:
                                Button {
                                    deleteFavorite()
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .font(.title)
                                        .foregroundColor(ColorManager.accentColor)
                                }
        )
    }
    
    func deleteFavorite() {
        mOC.delete(favorite)
        try? self.mOC.save()
        presentationMode.wrappedValue.dismiss()
        print(favorite)
    }
    
}
