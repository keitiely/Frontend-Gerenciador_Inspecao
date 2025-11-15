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
    @Published var userRole: String? = "coordenador"
    private(set) var currentUser: User? = nil
    
    
    //    Para TESTAR, inicializamos o AuthManager com um
    //    utilizador 'mock' (falso).
    init() {
        if isLoggedIn {
            self.currentUser = User(id: "1", nome: "Keitiely", role: "coordenador")
        }
    }
    
    
    // Api Service conecta aqui
    func login(email: String, pass: String) async -> Bool {
        
        // login request no model
        let loginRequest = LoginRequest(email: email, password: pass)
        
        do {
            // Chama a API (que vamos criar no APIService)
            let loginResponse = try await APIService.shared.login(request: loginRequest)
            
            // SUCESSO!
            // Atualiza os valores com a resposta REAL do backend
            self.currentUser = loginResponse.user
            self.isLoggedIn = true
            self.userRole = loginResponse.user.role // O 'role' vem da API
            
            return true
            
        } catch {
            // FALHA
            self.isLoggedIn = false
            self.userRole = nil
            self.currentUser = nil
            print("Erro no login: \(error)") // Mostra o erro na console
            return false
        }
    }
    
    func logout() {
        self.isLoggedIn = false
        self.userRole = nil
        self.currentUser = nil // Limpa o utilizador
    }
}
