//
//  QuadraDeyalhe.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//


import Foundation
import Combine

class QuadraDetalheViewModel: ObservableObject {
    
    @Published var inspecoes: [Inspecao] = []
    @Published var isLoading: Bool = false

    let quadra: Quadra
    
    init(quadra: Quadra) {
        self.quadra = quadra
        carregarInspecoes() 
    }
    
    func carregarInspecoes() {
        self.isLoading = true
        
        // --- PONTO DE CONEXÃO COM O BACK-END ---
        //
        // Aqui, você chamará sua APIService passando o ID da quadra:
        // ex: APIService.shared.buscarInspecoes(quadraID: quadra.id) { (inspecoes) in
        //     self.inspecoes = inspecoes
        //     self.isLoading = false
        // }
        //
        // --- FIM DA CONEXÃO COM O BACK-END ---
        
        // Por enquanto, usamos "Dados de Mock" (teste)
        // Simulando uma busca que demora 1 segundo.
            
            // Simula a lista de inspeções vinda do banco para esta quadra
            self.inspecoes = [
                Inspecao(nome: "Inspeção 1", endereco: "Endereço: Quadra 29, Conjunto C, Casa 29", statusVisita: .concluida),
                Inspecao(nome: "Inspeção 2", endereco: "Endereço: Quadra 29, Conjunto C, Casa 30", statusVisita: .concluida),
                Inspecao(nome: "Inspeção 3", endereco: "Endereço: Quadra 29, Conjunto D, Casa 01", statusVisita: .concluida)
            ]
            
            self.isLoading = false
        
    }
}
