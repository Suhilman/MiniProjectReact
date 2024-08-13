import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
    @State private var isAuthenticated = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("LOGIN")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            Text("Mini Project PhinCon")
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 20)
                            .padding(.top, 20)

                        HStack {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 20)
                            } else {
                                SecureField("Password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 20)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 20)
                        }

                        Button(action: {
                            authenticateUser()
                        }) {
                            Text("Login")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)

                        NavigationLink(destination: PokemonListView().navigationBarBackButtonHidden(true), isActive: $isAuthenticated) {
                            EmptyView()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func authenticateUser() {
        let correctUsername = "Admin"
        let correctPassword = "admin"
        
        if username.lowercased() == correctUsername.lowercased() && password == correctPassword {
            isAuthenticated = true
        } else {
            isAuthenticated = false
            alertMessage = "Invalid username or password. Please try again."
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
