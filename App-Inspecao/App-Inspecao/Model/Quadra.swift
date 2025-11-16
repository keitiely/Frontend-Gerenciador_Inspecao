//
//  Quadra.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import Foundation

struct Quadra: Codable, Identifiable {
    let id: String
    let nome: String
    let status: QuadraStatus
    let agenteNome: String?
    let numeroInspecoes: Int
    // 2. "CodingKeys" para traduzir os nomes da API (ex: "agente_nome")
    //    para os nomes do seu app (ex: "agenteNome").
    enum CodingKeys: String, CodingKey {
        case id
        case nome
        case status
        case agenteNome = "agente_nome"
        case numeroInspecoes = "numero_inspecoes"
    }
    
    // 3. O Enum de status "à prova de API"
    enum QuadraStatus: String, Codable {
        case naoAtribuida = "NAO_ATRIBUIDA"
        case pendente = "PENDENTE"
        case concluida = "CONCLUIDA"    // Valor real da API
        case unknown = "UNKNOWN"        // Caso de segurança
        
        public init(from decoder: Decoder) throws {
            // Isso garante que seu app não quebre se a API
            // mandar um status novo que você não previu.
            self = try QuadraStatus(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .unknown
        }
    }
    
    var nomeFormatado: String {
        return nome
    }
    
    var statusTexto: String {
        switch status {
        case .naoAtribuida:
            return "Não Atribuída"
        case .pendente:
            return "Pendente"
        case .concluida:
            return "Concluído"
        case .unknown:
            return "Desconhecido"
        }
    }
}
