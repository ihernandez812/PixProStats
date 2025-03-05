//
//  LeagueListViewModel.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/22/25.
//

import Foundation
import Combine

final class LeagueViewModel: ObservableObject {
    @Published var league: League?
    static var ALL_TIME: Int = -1
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getLeague()
    }
    
    func getLeague() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/ihernandez812/PixProBaseballStats/refs/heads/SWITCH_TO_JSON_DATABASE/pix_pro_stats/src/seasons/league.json") else{
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: League.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error Fetching Season:", error   )
                case .finished:
                    print("Got Seasons!!!")
                }
            } receiveValue: { [weak self] result in
                self?.league = result
            }
            .store(in: &cancellables)
        
    }
}
