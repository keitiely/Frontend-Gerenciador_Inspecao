//
//  Quadra.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import Foundation

// 1. Adicionamos 'Codable' para a API
struct Quadra: Codable, Identifiable {
    let id: String
    let nome: String
    let status: QuadraStatus
    let agenteNome: String?
    let numeroInspecoes: Int
    
    // O Enum de 3 estados que o Coordenador precisa
    enum QuadraStatus: String, Codable {
        case naoAtribuida
        case pendente
        case concluida
    }
    
    
    // --- SUAS VARIÁVEIS COMPUTADAS (Atualizadas) ---
    
    // 'nomeFormatado' agora só retorna o 'nome'
    var nomeFormatado: String {
        return nome
    }
    
    // 'statusTexto' agora lê o 'enum'
    var statusTexto: String {
        switch status {
        case .naoAtribuida:
            return "Não Atribuída"
        case .pendente:
            return "Pendente"
        case .concluida:
            return "Concluído"
        }
    }
}
