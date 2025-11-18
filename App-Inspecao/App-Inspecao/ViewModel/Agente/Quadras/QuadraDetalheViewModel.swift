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
    }
    
    func carregarInspecoes() async {
            self.isLoading = true
            defer { self.isLoading = false }
            
            do {
                // --- PONTO DE CONEXÃO COM O BACK-END ---
                 self.inspecoes = try await APIService.shared.buscarInspecoes(quadraID: quadra.id)
                
                // --- INÍCIO DO MOCK  TESTE---
//                try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//                self.inspecoes = [
//                    Inspecao(
//                        id: "..",
//                        nome: "Inspeção 1",
//                        quadraNome: quadra.nome,
//                        endereco: "Endereço: Quadra 29, Conjunto C, Casa 29",
//                        horario: "09:00",
//                        data: "08/09/23",
//                        relatorioTexto: "Relatório de teste 1",
//                        statusVisita: .concluida
//                    ),
//                    Inspecao(
//                        id: "..",
//                        nome: "Inspeção 2",
//                        quadraNome: quadra.nome,
//                        endereco: "Endereço: Quadra 29, Conjunto C, Casa 30",
//                        horario: "10:30",
//                        data: "08/09/23",
//                        relatorioTexto: "Relatório de teste 2",
//                        statusVisita: .concluida
//                    ),
//                    Inspecao(
//                        id: "...",
//                        nome: "Inspeção 3",
//                        quadraNome: quadra.nome,
//                        endereco: "Endereço: Quadra 29, Conjunto D, Casa 01",
//                        horario: "14:15",
//                        data: "08/09/23",
//                        relatorioTexto: "Relatório de teste 3",
//                        statusVisita: .concluida
//                    )
//                ]
//                // --- FIM DO MOCK ---
                
            } catch {
                print("Erro ao carregar inspeções: \(error)")
            }
        }
    }
