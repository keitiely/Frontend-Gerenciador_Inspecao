//
//  AddInspencaoViewModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//
import Foundation
import Combine
import UIKit
import SwiftUI

@MainActor
class AddInspecaoViewModel: ObservableObject {
    
    let quadra: Quadra
    private let agenteID: String 
    
    @Published var imagens: [UIImage] = []
    @Published var imagensBase64: [String] = []

    @Published var numeroCasa: String = ""
    @Published var complemento: String = ""
    @Published var statusVisita: StatusVisita = .concluida // Valor padrão
    
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
    
    init(quadra: Quadra, agenteID: String) {
        self.quadra = quadra
        self.agenteID = agenteID // <-- SALVE O ID
        
        //vazios para o usuário digitar
        self.horario = ""
        self.data = ""
    }
    
    
    //importar imagme
    func adicionarImagem(_ imagem: UIImage) {
        imagens.append(imagem)
        
        // Converte para Base64 e salva
        //    (comprime a imagem para 80% da qualidade para
        //    não enviar arquivos gigantes para a API)
        if let imagemData = imagem.jpegData(compressionQuality: 0.8),
           let imagemBase64String = imagemData.base64EncodedString() as String? {
            
            imagensBase64.append(imagemBase64String)
        }
    }
    
    func registrarInspecao() async {
        isLoading = true
        defer { isLoading = false }
        
        // 1. "Traduzir" o status de visita para o backend
                // (Ajuste essa lógica conforme sua regra de negócio)
                let statusString: String
                switch statusVisita {
                case .concluida:
                    statusString = "aceita"
                case .pendente:
                    statusString = "morador_ausente"
                default:
                    statusString = "pendente"
                }
        
        
        let request = CreateInspecaoRequest(
                    id_quadra: quadra.id,
                    id_agente: self.agenteID,
                    numero_casa: self.numeroCasa,       // <-- DADO CORRETO
                    complemento: self.complemento.isEmpty ? nil : self.complemento, // <-- DADO CORRETO
                    status_visita: statusString,       // <-- DADO CORRETO
                    relatorio: relatorioTexto,
                    fotos: self.imagensBase64,
                    data_visita: self.data,
                    hora_visita: self.horario
                )
        
        do {
            // --- PONTO DA API ---
            try await APIService.shared.registrarInspecao(request: request)
            
//            // --- MOCK ---
//            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
//            // --- FIM MOCK ---
            
            // Sucesso!
            self.registroSucesso = true
            
        } catch {
            print("Erro ao registrar inspeção: \(error)")
            self.erroMensagem = "Não foi possível registrar a inspeção."
        }
    }
}
