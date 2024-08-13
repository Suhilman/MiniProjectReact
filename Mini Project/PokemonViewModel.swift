import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var capturedPokemons: [CapturedPokemon] = []
    
    func fetchPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decodedResponse = try? JSONDecoder().decode(PokemonResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonList = decodedResponse?.results.map {
                        Pokemon(name: $0.name, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.getPokemonID(from: $0.url)).png", moves: [], types: [])
                    } ?? []
                }
            }
        }.resume()
    }
    
    private func getPokemonID(from url: String) -> String {
        let components = url.split(separator: "/")
        return String(components[components.count - 2])
    }
    
    func releasePokemon(_ pokemon: CapturedPokemon) {
        // Implement release logic
    }
}

struct PokemonResponse: Codable {
    var results: [PokemonAPIResult]
}

struct PokemonAPIResult: Codable {
    var name: String
    var url: String
}

struct Pokemon: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var moves: [String]
    var types: [String]
}

struct CapturedPokemon: Identifiable {
    var id = UUID()
    var name: String
    var nickname: String
}
