//
//  LoginViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import Combine


@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var user: String = ""
    @Published var senha: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    //login que o view escuta da authmanager
    func login(authManager: AuthManager) async {
        
        //Limpa o erro e mostra o loading
        self.errorMessage = ""
        self.isLoading = true
        
        // Chama o AuthManager (o cérebro "global")
        let success = await authManager.login(email: user, pass: senha)
        
        // Esconde o loading
        self.isLoading = false
        
        // 7. Se falhou, mostra a mensagem de erro
        if !success {
            self.errorMessage = "Usuário ou senha inválidos."
        }
        
        // Se deu 'success', não fazemos NADA.
        // O AuthManager já mudou o 'isLoggedIn' e o
        // ContentView JÁ ESTÁ NAVEGANDO a tela.
    }
}
