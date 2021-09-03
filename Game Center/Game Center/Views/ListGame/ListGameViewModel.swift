//
//  ListGameViewModel.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 20/08/21.
//

import Foundation

class ListGameViewModel: ObservableObject {
    @Published var result: ListGame?
    @Published var listgame: [Game] = []
    @Published var keywordSearch = ""
    @Published var loading = false
    
    init() {
        loadNewList()
    }
    
    func loadNewList() {
        listgame.removeAll()
        getListGames { data in
            self.result = data
            if let results = data.results {
                self.listgame = results
            }
        }
    }
    
    func clearSearch() {
        keywordSearch = ""
        loadNewList()
    }
    
    func searchResult() {
        if !keywordSearch.isEmpty {
            loadNewList()
        }
    }
    
    func getListGames(completion: @escaping (ListGame) -> Void) {
        self.loading = true
        var queryItems: [URLQueryItem]? = []
        var urlString = ""
        
        urlString = Constant().baseUrl+Constant().gamesPath
        if !keywordSearch.isEmpty {
            queryItems?.append(.init(name: "search", value: keywordSearch))
        }
        
        guard !urlString.isEmpty else { return }
        ApiService.shared.getData(from: urlString, queryItems: queryItems) { (result: Result<ListGame, ErrorCase>, _) in
            DispatchQueue.main.async {
                self.loading = false
                switch result {
                case .success(let data) :
                    completion(data)
                case .failure(let error) :
                    print(error.localizedDescription.description)
                }
            }
        }
    }
    
}
