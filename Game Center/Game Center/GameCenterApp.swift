//
//  Game_CenterApp.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 13/08/21.
//

import SwiftUI

@main
struct GameCenterApp: App {
    let context = GameFavoriteProvider.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            ListGameView().environment(\.managedObjectContext, context)
        }
    }
}
