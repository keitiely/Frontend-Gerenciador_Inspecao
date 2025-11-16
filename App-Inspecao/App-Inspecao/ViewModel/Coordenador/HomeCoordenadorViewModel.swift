//
//  HomeViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
//
import Combine

@MainActor
class HomeCoordenadorViewModel: ObservableObject {
    
    @Published var nomeCoordenador: String = "..."

    init() {}

    // A View vai chamar esta função
    func carregarDados(authManager: AuthManager) {
        if let nome = authManager.currentUser?.nome {
            self.nomeCoordenador = nome
        } else {
            self.nomeCoordenador = "..."
        }
    }
}
