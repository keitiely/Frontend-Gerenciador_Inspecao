//
//  AgentesCoordenadorViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation
import Combine

@MainActor
class AgentesCoordenadorViewModel: ObservableObject {
    
    @Published var agentes: [User] = []
    @Published var isLoading = false
    @Published var erroMensagem: String? = nil
    
    func carregarAgentes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // --- PONTO DA API ---
            // self.agentes = try await APIService.shared.buscarTodosAgentes()
            
            // --- MOCK ---
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            self.agentes = [
                User(id: "agente_1", nome: "Marcos", role: "agente"),
                User(id: "agente_2", nome: "Ronaldo", role: "agente"),
                User(id: "agente_3", nome: "Nubia", role: "agente"),
                User(id: "agente_4", nome: "Eustaquio", role: "agente")
            ]
            // --- FIM MOCK ---
            
        } catch {
            print("Erro ao carregar agentes: \(error)")
            self.erroMensagem = "Não foi possível carregar os agentes."
        }
    }
}
