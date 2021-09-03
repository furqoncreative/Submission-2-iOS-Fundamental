//
//  DetailGameView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 20/08/21.
//

import SwiftUI
import Kingfisher

struct DetailGameView: View {
    var gameId: Int
    var favoritesRequest: FetchRequest<GameFavorite>
    var favorites: FetchedResults<GameFavorite> {favoritesRequest.wrappedValue}
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = DetailGameViewModel()
    
    init(gameId: Int) {
        self.gameId = gameId
        self.favoritesRequest = FetchRequest(entity: GameFavorite.entity(), sortDescriptors: [], predicate: NSPredicate(format: "gameId == %@", NSNumber(value: gameId)))
    }
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor.ignoresSafeArea(edges: .all)
            Group {
                if let game = viewModel.game {
                    
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                        KFImage(URL(string: game.backgroundImage ?? ""))
                            .resizable()
                            .loadImmediately()
                            .frame(height: 350)
                            .modifier(ImageDetailModifier())
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 2) {
                                Text("\(String(format: "%.2f", game.rating ?? 0.0))")
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
                            
                            Text(game.name)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(ColorManager.primaryTextColor)
                            
                            Text(game.released)
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(ColorManager.secondaryTextColor)
                                .padding(.top, 1)
                            
                            LazyHStack {
                                if let genres = game.genres {
                                    if !genres.isEmpty {
                                        ScrollView(.horizontal) {
                                            HStack {
                                                ForEach(game.genres) { genre in
                                                    GenreView(genre: genre.name)
                                                }
                                            }
                                        }
                                    }
                                }
                            }.frame(height: 25)
                            
                            Text(game.description)
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
                } else {
                    VStack(spacing: 16.0) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Text("Loading...")
                    }
                }
            }
            .onAppear {
                viewModel.gameID = gameId
                viewModel.getGameDetail()
            }
            
        }
        
        .navigationBarItems(trailing: Group {
            self.favorites.count == 0 ? Button(action: {
                if viewModel.game?.id != nil {addFavorite()}
            }, label: {
                Image(systemName: "heart")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            }) : Button(action: {
                let favorite = self.favorites.first
                if favorite?.id != nil {deleteFavorite(favorite: favorite)}
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            })
        }
        )
        
    }
    
    func addFavorite() {
        let favorite = GameFavorite(context: self.viewContext)
        let game = viewModel.game
        favorite.gameId = Int32(game?.id ?? 0)
        favorite.gameName = game?.name
        favorite.gameRating = Float(game?.rating ?? 0.0)
        favorite.gameRelease = game?.released
        favorite.gameBacground = game?.backgroundImage
        favorite.gameDescription = game?.description
        try? self.viewContext.save()
    }
    
    func deleteFavorite(favorite: GameFavorite?) {
        viewContext.delete(favorite ?? GameFavorite(context: self.viewContext))
        try? self.viewContext.save()
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGameView(gameId: 3498)
    }
}

struct GenreView: View {
    let genre: String
    var body: some View {
        Text(genre)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 10, weight: .light, design: .default))
            .multilineTextAlignment(.center)
            .padding(.all, 8)
            .frame(maxWidth: 65, maxHeight: 25)
            .background(Rectangle().fill(ColorManager.primaryColor).cornerRadius(20))
    }
}
