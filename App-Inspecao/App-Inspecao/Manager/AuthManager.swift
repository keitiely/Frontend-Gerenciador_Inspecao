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
    
    @Published private(set) var currentUser: User? = nil
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    var userRole: String? {
        currentUser?.role
    }
    
    
    //    Para TESTAR, inicializamos o AuthManager com um
    //    utilizador 'mock' (falso).
    init() {
        // --- CONTROLO DE TESTE ---
        // Para testar a HomeCoordenadorView:
        self.currentUser = User(id: "1", nome: "Keitiely", role: "coordenador")
        // Para testar a LoginView (VERSÃO FINAL):
//         self.currentUser = nil
        // --- FIM DO CONTROLO DE TESTE ---
    }
    
    // Api Service conecta aqui
    func login(email: String, pass: String) async -> Bool {
        
        let loginRequest = LoginRequest(email: email, password: pass)
        
        do {
            let loginResponse = try await APIService.shared.login(request: loginRequest)
            
            // SUCESSO!
            // Esta é a ÚNICA linha que muda o estado
            self.currentUser = loginResponse.user
            return true
            
        } catch {
            // FALHA
            self.currentUser = nil
            print("Erro no login: \(error)")
            return false
        }
    }
    
    func logout() {
        self.currentUser = nil
    }
}

