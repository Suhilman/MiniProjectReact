import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemonList, id: \.name) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    HStack {
                        AsyncImage(url: URL(string: pokemon.imageUrl))
                            .frame(width: 50, height: 50)
                        Text(pokemon.name.capitalized)
                    }
                }
            }
            .navigationBarTitle("Pokemon List")
            .navigationBarItems(trailing: Button("Logout") {
                logout()
            })
            .onAppear {
                viewModel.fetchPokemonList()
            }
        }
    }
    
    private func logout() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
