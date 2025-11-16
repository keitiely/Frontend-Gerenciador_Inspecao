//
//  AtribuirAgenteViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//
import Foundation
import Combine

@MainActor
class AtribuirAgenteViewModel: ObservableObject {
    
    // Lista de agentes que virá da API
    @Published var agentesDisponiveis: [User] = []
    
    // Feedback para o usuário
    @Published var isLoading: Bool = false
    @Published var atribuicaoSucesso: Bool = false
    @Published var erroMensagem: String? = nil
    
    
    
    // Funcao para carregar os agentes
    func carregarAgentesDisponiveis() async {
        isLoading = true
        // Garante que o loading para no final, mesmo se der erro
        defer { isLoading = false }
        
        do {
            //Substituir pela chamada api
            // self.agentesDisponiveis = try await APIService.shared.fetchAvailableAgents()

            // --- INÍCIO DO MOCK (Dados Falsos para Teste) ---
            // Simula um delay de 1 segundo da rede
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            
            self.agentesDisponiveis = [
                User(id: "agente_1", nome: "Marcos", role: "agente"),
                User(id: "agente_2", nome: "Ronaldo", role: "agente"),
                User(id: "agente_3", nome: "Nubia", role: "agente"),
                User(id: "agente_4", nome: "Eustaquio", role: "agente")
            ]
            // --- FIM DO MOCK ---
            
        } catch {
            print("Erro ao carregar agentes: \(error)")
            self.erroMensagem = "Não foi possível carregar os agentes. Tente novamente."
        }
    }
    
    // Funcao para atribuir Agente
    func atribuirAgente(quadraID: String, agenteID: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // substituir pela chamada api
            // try await APIService.shared.assignAgentToQuadra(quadraID: quadraID, agentID: agenteID)
            
            // --- INÍCIO DO MOCK (Simula Sucesso) ---
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            self.atribuicaoSucesso = true
            // --- FIM DO MOCK ---
            
        } catch {
            print("Erro ao atribuir agente: \(error)")
            self.erroMensagem = "Não foi possível atribuir o agente. Tente novamente."
        }
    }
}
