//
//  AgenteViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import Combine


class AgenteViewModel: ObservableObject {
    
 
    @Published var agente: Agente?
    @Published var quadras: [Quadra] = []
    @Published var mesAtual: String = "Fev" //mudar depois
    @Published var isLoading: Bool = false
    

    init() {
        carregarDados()
    }

    func carregarDados() {
        self.isLoading = true
        
        // --- PONTO DE CONEXÃO COM O BACK-END ---
        //
        // No futuro, você vai chamar sua APIService aqui.
        // ex: APIService.shared.buscarDadosAgente { (agente, quadras) in
        //     self.agente = agente
        //     self.quadras = quadras
        //     self.isLoading = false
        // }
        //
        // --- FIM DA CONEXÃO COM O BACK-END ---
        
        
        // Por enquanto dados mock
        // para simular a resposta do banco de dados.
            // Simula o agente logado
            self.agente = Agente(id: "123", nome: "João")
 
    
            // Simula a lista de quadras vinda do banco
            self.quadras = [
                Quadra(numero: 7, numeroInspecoes: 20, isPendente: true), // Pendente
                Quadra(numero: 6, numeroInspecoes: 20, isPendente: false), // Concluído
                Quadra(numero: 5, numeroInspecoes: 20, isPendente: false),
                Quadra(numero: 4, numeroInspecoes: 20, isPendente: false),
                Quadra(numero: 3, numeroInspecoes: 20, isPendente: false),
                Quadra(numero: 2, numeroInspecoes: 20, isPendente: false),
                Quadra(numero: 1, numeroInspecoes: 20, isPendente: false)
            ]
            
            self.isLoading = false
    }
}
