//
//  ResumoQuadraViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation
import Combine


struct ResumoData: Identifiable {
    let id = UUID()
    let nome: String
    let valor: Int
    
    // Converte o nome para a legenda
    var nomeLegenda: String {
        nome == "visitadas" ? "Casas visitadas" : "Casas fechadas"
    }
}

@MainActor
class ResumoQuadraViewModel: ObservableObject {
    
    let quadra: Quadra
    
    @Published var chartData: [ResumoData] = []
    @Published var percentualVisitadas: Double = 0.0
    
    @Published var isLoading: Bool = false
    @Published var finalizacaoSucesso: Bool = false
    @Published var erroMensagem: String? = nil
    
    init(quadra: Quadra) {
        self.quadra = quadra
    }
    
    func carregarResumo() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // --- PONTO DA API ---
             let resumo = try await APIService.shared.buscarResumo(quadraID: quadra.id)
             let visitadas = resumo.visitadas
            let fechadas = resumo.fechadas
            
            // mock teste
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            let visitadas = 75
//            let fechadas = 25
            // fim mock
            
            let total = visitadas + fechadas
            
            self.chartData = [
                ResumoData(nome: "visitadas", valor: visitadas),
                ResumoData(nome: "fechadas", valor: fechadas)
            ]
            
            if total > 0 {
                self.percentualVisitadas = Double(visitadas) / Double(total)
            }
            
        } catch {
            self.erroMensagem = "Não foi possível carregar o resumo."
        }
    }
    
    func finalizarQuadra() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // --- PONTO DA API ---
             try await APIService.shared.finalizarQuadra(quadraID: quadra.id)
            
            // mock
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            //fim mock
            
            self.finalizacaoSucesso = true
            
        } catch {
            self.erroMensagem = "Não foi possível finalizar a quadra."
        }
    }
}
