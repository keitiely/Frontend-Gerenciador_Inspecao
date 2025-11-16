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
        
        // A API de verdade usaria o ID:
        // let detalhes = try await APIService.shared.buscarDetalhesAgente(id: agente.id)
        
        //mock de Teste
        // Simula a espera da rede
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        // Simula dados diferentes para IDs diferentes
        switch agente.id {
        case "agente_1": // Marcos
            self.codigoAgente = "A01234"
            self.nomeCompleto = "Marcos Antonio Xavier"
            self.statusAgente = "Ativo"
        case "agente_2": // Ronaldo
            self.codigoAgente = "A05678"
            self.nomeCompleto = "Ronaldo Souza Lima"
            self.statusAgente = "Ativo"
        case "agente_3": // Nubia
            self.codigoAgente = "A09987"
            self.nomeCompleto = "Nubia Oliveira"
            self.statusAgente = "Férias"
        default:
            self.codigoAgente = "Indefinido"
            self.nomeCompleto = "Não encontrado"
            self.statusAgente = "Inativo"
        }
        // --- FIM DO MOCK ---
    }
}
