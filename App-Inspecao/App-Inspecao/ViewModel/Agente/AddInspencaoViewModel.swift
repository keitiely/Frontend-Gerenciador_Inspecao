//
//  AddInspencaoViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//
import Foundation
import Combine

@MainActor
class AddInspecaoViewModel: ObservableObject {
    
    let quadra: Quadra
    

    @Published var endereco: String = ""
    @Published var horario: String = ""
    @Published var data: String = ""
    @Published var relatorioTexto: String = ""
    // TODO: Adicionar @Published var imagens: [UIImage] = []
    
  
    @Published var isLoading: Bool = false
    @Published var registroSucesso: Bool = false
    @Published var erroMensagem: String? = nil
    
    // Formatadores para preencher a data/hora
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
    
    init(quadra: Quadra) {
        self.quadra = quadra
        
        //vazios para o usuário digitar
        self.horario = ""
        self.data = ""
    }
    
    func registrarInspecao() async {
        isLoading = true
        defer { isLoading = false }
        
        // 1. Criar o objeto de request para a API
        // let request = CreateInspecaoRequest(
        //     quadraId: quadra.id,
        //     endereco: endereco,
        //     horario: horario,
        //     data: data,
        //     relatorio: relatorioTexto
        //     // ...imagens
        // )
        
        do {
            // --- PONTO DA API ---
            // try await APIService.shared.registrarInspecao(request)
            
            // --- MOCK ---
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            // --- FIM MOCK ---
            
            // Sucesso!
            self.registroSucesso = true
            
        } catch {
            print("Erro ao registrar inspeção: \(error)")
            self.erroMensagem = "Não foi possível registrar a inspeção."
        }
    }
}
