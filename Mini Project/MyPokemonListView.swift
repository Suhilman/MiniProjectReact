import SwiftUI

struct MyPokemonListView: View {
    @ObservedObject var viewModel: PokemonViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.capturedPokemons) { capturedPokemon in
                    HStack {
                        Text(capturedPokemon.nickname)
                        Spacer()
                        Button("Release") {
                            viewModel.releasePokemon(capturedPokemon)
                        }
                        .foregroundColor(.red)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("My Pokemon List")
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        offsets.map { viewModel.capturedPokemons[$0] }.forEach { pokemon in
            viewModel.releasePokemon(pokemon)
        }
    }
}
