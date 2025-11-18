//
//  QuadrasCoordenadorViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
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
    @Published var erroMensagem: String? = nil // Bom ter para erros
    
    init() {}
    
    func carregarQuadras() async {
        self.isLoading = true
    
        defer { self.isLoading = false }
    
        
        do {
            // --- PONTO DE CONEXÃO COM O BACK-END ---
             let todasQuadras = try await APIService.shared.getTodasAsQuadras()
            // --- FIM DA CONEXÃO ---
            

            // --- DADOS MOCK (FALSOS) por enquanto ---
            
//            // 5. Adicionei um "delay" falso para simular a rede
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            
//            let todasQuadras: [Quadra] = [
//                // Não Atribuídas
//                Quadra(id: "q1", nome: "Quadra 01", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
//                Quadra(id: "q2", nome: "Quadra 02", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
//                Quadra(id: "q7", nome: "Quadra 07", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 0),
//                
//                // Pendentes
//                Quadra(id: "q3", nome: "Quadra 03", status: .pendente, agenteNome: "Joao", numeroInspecoes: 5),
//                Quadra(id: "q4", nome: "Quadra 04", status: .pendente, agenteNome: "Marcos", numeroInspecoes: 8),
//                
//                // Concluídas
//                Quadra(id: "q5", nome: "Quadra 05", status: .concluida, agenteNome: "Leonidas", numeroInspecoes: 10),
//                Quadra(id: "q6", nome: "Quadra 06", status: .concluida, agenteNome: "Maria", numeroInspecoes: 12)
//            ]
            
            // O ViewModel faz o trabalho de separar a lista para a View
            self.quadrasNaoAtribuidas = todasQuadras.filter { $0.status == .naoAtribuida }
            self.quadrasPendentes = todasQuadras.filter { $0.status == .pendente }
            self.quadrasConcluidas = todasQuadras.filter { $0.status == .concluida }
            
        } catch {
            // Sempre bom ter um lugar para tratar erros
            print("Erro ao carregar quadras: \(error)")
            self.erroMensagem = "Falha ao carregar o painel."
        }
    }
}
