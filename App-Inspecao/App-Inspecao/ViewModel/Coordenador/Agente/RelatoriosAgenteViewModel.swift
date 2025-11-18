//
//  RelatoriosAgenteViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//
import Foundation
import Combine

@MainActor
class RelatoriosAgenteViewModel: ObservableObject {
    
    @Published var inspecoes: [Inspecao] = []
    @Published var isLoading = false
    let agente: User
    
    init(agente: User) {
        self.agente = agente
    }
    
    func carregarRelatorios() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            // --- PONTO DA API ---
             self.inspecoes = try await APIService.shared.buscarInspecoes(agenteID: agente.id)
            
            // --- MOCK ---
            // (Estes são os mesmos mocks de antes,
            // mas a API filtraria pelo agente)
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            self.inspecoes = [
//                Inspecao(
//                    id: "ins-001",
//                    nome: "Relatório 1",
//                    quadraNome: "Quadra-04",
//                    endereco: "Quadra 29, Conjunto C, Casa 29",
//                    horario: "22:00:44",
//                    data: "05/03/25",
//                    relatorioTexto: "Inspeção realizada com sucesso, águas dos vasos retiradas, aplicação de veneno nos pneus.",
//                    statusVisita: .concluida
//                ),
//                Inspecao(
//                    id: "ins-002",
//                    nome: "Relatório 2",
//                    quadraNome: "....",
//                    endereco: "Quadra 29, Conjunto C, Casa 30",
//                    horario: "14:30:10",
//                    data: "05/03/25",
//                    relatorioTexto: "Morador ausente, deixado notificação.",
//                    statusVisita: .pendente
//                )
//            ]
            // --- FIM MOCK ---
            
        } catch {
            print("Erro ao carregar relatórios do agente: \(error)")
        }
    }
}
