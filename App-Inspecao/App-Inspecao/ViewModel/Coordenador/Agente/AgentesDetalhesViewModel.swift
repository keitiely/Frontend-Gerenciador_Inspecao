//
//  AgentesDetalhesViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation
import Combine

@MainActor
class AgenteDetalheViewModel: ObservableObject {
    
    let agente: User
    
    // 2. Os dados de detalhe que vamos "carregar"
    @Published var codigoAgente: String = "..."
    @Published var nomeCompleto: String = "..."
    @Published var statusAgente: String = "Carregando..."
    @Published var isLoading: Bool = false
    
    init(agente: User) {
        self.agente = agente
    }
    
    // função que a API vai usar
    func carregarDetalhes() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            // A API de verdade usaria o ID:
            let detalhes = try await APIService.shared.buscarDetalhesAgente(id: agente.id)
            
            // Popula os dados com a resposta da API
            self.codigoAgente = detalhes.codigoAgente ?? "N/A"
            self.nomeCompleto = detalhes.nomeCompleto ?? "N/A"
            self.statusAgente = detalhes.statusAgente ?? "Indefinido"
        } catch {
            // Trata o erro da API e mantém valores padrão seguros
            self.codigoAgente = "N/A"
            self.nomeCompleto = "N/A"
            self.statusAgente = "Erro ao carregar"
            // Opcional: log do erro para debug
            print("Falha ao buscar detalhes do agente: \(error)")
        }
    }
}
