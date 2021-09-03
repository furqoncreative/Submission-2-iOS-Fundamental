//
//  FavoriteListView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 23/08/21.
//

import SwiftUI

struct ListFavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: GameFavorite.entity(), sortDescriptors: [])
    var favorite: FetchedResults<GameFavorite>
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor.ignoresSafeArea(edges: .all)
            Group {
                if favorite.count != 0 {
                    List {
                        ForEach(favorite, id: \.self) {favorite in
                            NavigationLink(destination: FavoriteDetailView(favorite: favorite),
                                           label: {
                                            ListFavoriteRow(favorite: favorite)
                                           })
                        }
                    }
                } else {
                    VStack {
                        Text("There is no favorite")
                    }
                }
            }
            .background(ColorManager.backgroundColor)
            .navigationBarTitle(Text("Favorite"), displayMode: .inline)
        }.background(ColorManager.backgroundColor)
    }
}

struct ListFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        ListFavoriteView()
    }
}
