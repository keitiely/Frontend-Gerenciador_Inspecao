//
//  RelatorioListViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation
import Combine

@MainActor
class RelatoriosListViewModel: ObservableObject {
    
    @Published var inspecoes: [Inspecao] = []
    @Published var isLoading: Bool = false
    @Published var erroMensagem: String? = nil
    

    let quadra: Quadra
    
    init(quadra: Quadra) {
        self.quadra = quadra
    }
    
    func carregarRelatorios() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            // --- PONTO DE CONEXÃO COM O BACK-END ---
             self.inspecoes = try await APIService.shared.buscarInspecoes(quadraID: quadra.id)
            
            // --- INÍCIO DO MOCK (com dados prontos para a API) ---
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            
//            self.inspecoes = [
//                Inspecao(
//                    id: "ins-001",
//                    nome: "Relatório 1",
//                    quadraNome: quadra.nome,
//                    endereco: "Quadra 29, Conjunto C, Casa 29",
//                    horario: "22:00:44",
//                    data: "05/03/25",
//                    relatorioTexto: "Inspeção realizada com sucesso, águas dos vasos retiradas, aplicação de veneno nos pneus.",
//                    statusVisita: .concluida
//                ),
//                Inspecao(
//                    id: "ins-002",
//                    nome: "Relatório 2",
//                    quadraNome: quadra.nome,
//                    endereco: "Quadra 29, Conjunto C, Casa 30",
//                    horario: "14:30:10",
//                    data: "05/03/25",
//                    relatorioTexto: "Morador ausente, deixado notificação.",
//                    statusVisita: .pendente
//                )
//            ]
            // --- FIM DO MOCK ---
            
        } catch {
            print("Erro ao carregar inspeções: \(error)")
            self.erroMensagem = "Não foi possível carregar os relatórios."
        }
    }
}
