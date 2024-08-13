import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon
    @State private var catchResult: String? = nil
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack{
                    AsyncImage(url: URL(string: pokemon.imageUrl))
                        .frame(width: 200, height: 200)
                        .padding(.top, 10)
                    
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: {
                        catchPokemon()
                    }) {
                        Text("SAVE")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }.padding()
                    
                    if let result = catchResult {
                        Text(result)
                            .padding()
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
        }
    }
    
    private func catchPokemon() {
        if Bool.random() {
            catchResult = "Success! You caught \(pokemon.name)."
        } else {
            catchResult = "Failed to catch \(pokemon.name)."
        }
    }
}
