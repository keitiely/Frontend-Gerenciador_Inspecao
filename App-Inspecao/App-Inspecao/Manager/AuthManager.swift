//
//  AuthManager.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import Combine

@MainActor
class AuthManager: ObservableObject {
    
    // O app inteiro vai olhar para essas duas variáveis
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String? = "Coordenador"
    
    // Use seu APIService aqui
    func login(email: String, pass: String) async -> Bool {
        // ...
        // Chame seu APIService.shared.login(...)
        // ...
        
        // Se der sucesso:
        self.isLoggedIn = true
        self.userRole = "coordenador" // Pegar isso da resposta da API
        return true
        
        // Se der falha:
        // self.isLoggedIn = false
        // return false
    }
    
    func logout() {
        self.isLoggedIn = false
        self.userRole = nil
    }
}
