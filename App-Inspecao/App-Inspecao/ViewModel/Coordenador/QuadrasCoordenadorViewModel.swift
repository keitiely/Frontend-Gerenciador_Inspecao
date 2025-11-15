//
//  QuadrasCoordenadorViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import Combine
import Foundation
import SwiftUI

@MainActor
class QuadrasCoordenadorViewModel: ObservableObject {
    
    @Published var quadrasNaoAtribuidas: [Quadra] = []
    @Published var quadrasPendentes: [Quadra] = []
    @Published var quadrasConcluidas: [Quadra] = []
    
    @Published var isLoading: Bool = false
    

    init() {}
 
    func carregarDados(authManager: AuthManager) {
        // (Evita recarregar se a tela reaparecer)
        if !quadrasNaoAtribuidas.isEmpty { return }
        
        self.isLoading = true
        
        // --- PONTO DE CONEXÃO COM O BACK-END ---
        //
        // 3. No futuro, você vai chamar a API (com o token)
        // let token = authManager.token // (Precisamos de adicionar o token ao AuthManager)
        // let todasQuadras = try await APIService.shared.getTodasAsQuadras(token: token)
        //
        // --- FIM DA CONEXÃO ---
        
        
        // --- DADOS MOCK (FALSOS) por agora ---
        // (A usar o seu Model/Quadra.swift PERFEITO)
        let todasQuadras: [Quadra] = [
            // Não Atribuídas
            Quadra(id: "q1", nome: "Quadra 01", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
            Quadra(id: "q2", nome: "Quadra 02", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
            Quadra(id: "q7", nome: "Quadra 07", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
            
            // Pendentes
            Quadra(id: "q3", nome: "Quadra 03", status: .pendente, agenteNome: "Joao", numeroInspecoes: 5),
            Quadra(id: "q4", nome: "Quadra 04", status: .pendente, agenteNome: "Marcos", numeroInspecoes: 8),
            
            // Concluídas
            Quadra(id: "q5", nome: "Quadra 05", status: .concluida, agenteNome: "Leonidas", numeroInspecoes: 10),
            Quadra(id: "q6", nome: "Quadra 06", status: .concluida, agenteNome: "Maria", numeroInspecoes: 12)
        ]
        
       
        // O ViewModel faz o trabalho de separar a lista para a View
        self.quadrasNaoAtribuidas = todasQuadras.filter { $0.status == .naoAtribuida }
        self.quadrasPendentes = todasQuadras.filter { $0.status == .pendente }
        self.quadrasConcluidas = todasQuadras.filter { $0.status == .concluida }
        
        self.isLoading = false
    }
}
