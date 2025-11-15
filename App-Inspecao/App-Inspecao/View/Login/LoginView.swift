//
//  LoginView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authManager: AuthManager
    @State private var user = ""
    @State private var senha = ""
    
    
    var body: some View {
        VStack {
 
//            Spacer()
            Text("FazAgente")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(Color.blue)
                .padding(.top, 70)
                .padding(60)
            
                
        
            // Caixa de login
            VStack {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // campo email
                TextField("Usuário", text: $user)
                    .padding(12)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)

                // senha
                SecureField("Senha", text: $senha)
                    .padding(12)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(8)

                // Botão Entrar
                Button(action: {
                    Task {
                        await authManager.login(email: user, pass: senha)
                    }
                }) {
                    Text("Entrar")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color(UIColor.systemGray3))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
            }
            .padding(30)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)

            Spacer() // Empurra tudo para cima
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager()) // Adiciona um AuthManager falso
    }
}
