//
//  AgenteViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import Combine

@MainActor
class AgenteViewModel: ObservableObject {
    @Published var agente: User?
    @Published var quadras: [Quadra] = []
    @Published var mesAtual: String = "Fev" //mudar depois
    @Published var isLoading: Bool = false
    
    
    func carregarDados(authManager: AuthManager) async {
        if agente != nil { return }
        self.isLoading = true
        defer { self.isLoading = false } // Garante que o loading para
        
        guard let agenteLogado = authManager.currentUser else {
            return
        }
        self.agente = agenteLogado
        
        do {
            // --- PONTO DE CONEXÃO COM O BACK-END ---
             let minhasQuadras = try await APIService.shared.getMinhasQuadras(agenteID: agenteLogado.id)
            
            // --- INÍCIO DO MOCK TESTE---
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            let todasQuadrasMock: [Quadra] = [
//                Quadra(id: "q3", nome: "Quadra 03", status: .pendente, agenteNome: agenteLogado.nome, numeroInspecoes: 8),
//                Quadra(id: "q5", nome: "Quadra 05", status: .concluida, agenteNome: agenteLogado.nome, numeroInspecoes: 9)
//            ]
//            self.quadras = todasQuadrasMock // O filtro do mock já está feito
            // --- FIM DO MOCK ---
            
            self.quadras = minhasQuadras// O filtro do mock já está feito
            
        } catch {
            print("Erro ao carregar quadras do agente: \(error)")
            // self.erroMensagem = "Não foi possível carregar suas quadras."
        }
    }
}
