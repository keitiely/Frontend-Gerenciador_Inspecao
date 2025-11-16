//
//  Inspecao.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
struct Inspecao: Codable, Identifiable {

    let id: String
    let nome: String
    let quadraNome: String
    let endereco: String
    let horario: String
    let data: String
    let relatorioTexto: String
    let statusVisita: StatusVisita
//    let imagensURL: [String]? //adicionar depois
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case nome
        case quadraNome = "quadra_nome"
        case endereco
        case horario
        case data
        case relatorioTexto = "relatorio_texto"
        case statusVisita = "status_visita" // Ex: API manda "status_visita"
//        case imagensURL = "imagens_url"
    }
}
enum StatusVisita: String, Codable, CaseIterable {
    case pendente = "PENDENTE"
    case concluida = "CONCLUIDA"
    case unknown = "UNKNOWN"
    
    // se a API mandar um status que você não espera.
    // Ele simplesmente vai tratar como .unknown
    public init(from decoder: Decoder) throws {
        self = try StatusVisita(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .unknown
    }
}
