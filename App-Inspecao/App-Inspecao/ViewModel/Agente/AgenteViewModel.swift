//
//  AgenteViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import Combine

@MainActor
class AgenteViewModel: ObservableObject {
    @Published var agente: User?
    @Published var quadras: [Quadra] = []
    @Published var mesAtual: String = "Fev" //mudar depois
    @Published var isLoading: Bool = false
    
    
    func carregarDados(authManager: AuthManager) {
        
        // Se o ViewModel já carregou, não faz nada
        //    (Evita recarregar se a tela reaparecer)
        if agente != nil { return }
        
        
        self.isLoading = true
        
        // --- PONTO DE CONEXÃO COM O BACK-END ---
        //
        // O ViewModel AGORA SABE quem é o agente logado
        guard let agenteLogado = authManager.currentUser else {
            self.isLoading = false
            return
        }
        
        self.agente = agenteLogado
        
        // chamar a API:
        //    let minhasQuadras = try await APIService.shared.getMinhasQuadras(token: authManager.token)
        //    self.quadras = minhasQuadras
        //
        // --- FIM DA CONEXÃO COM O BACK-END ---
         
         
        // --- DADOS MOCK (FALSOS) ATUALIZADOS ---
        //    (Usando o *novo* molde 'Quadra.swift')
        let todasQuadrasMock: [Quadra] = [
            Quadra(id: "q1", nome: "Quadra 01", status: .naoAtribuida, agenteNome: nil, numeroInspecoes: 6),
            Quadra(id: "q3", nome: "Quadra 03", status: .pendente, agenteNome: agenteLogado.nome, numeroInspecoes: 8),
            Quadra(id: "q4", nome: "Quadra 04", status: .pendente, agenteNome: "Outro Agente", numeroInspecoes: 6),
            Quadra(id: "q5", nome: "Quadra 05", status: .concluida, agenteNome: agenteLogado.nome, numeroInspecoes: 9)
        ]
        
        // 8. O Agente SÓ VÊ as quadras dele
        self.quadras = todasQuadrasMock.filter { $0.agenteNome == agenteLogado.nome }
        
        self.isLoading = false
    }
}
