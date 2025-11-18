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
    let fotos: [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case nome
        case quadraNome = "quadra_nome"
        case endereco
        case horario
        case data
        case relatorioTexto = "relatorio_texto"
        case statusVisita = "status_visita" // Ex: API manda "status_visita"
        case fotos
    }
}
