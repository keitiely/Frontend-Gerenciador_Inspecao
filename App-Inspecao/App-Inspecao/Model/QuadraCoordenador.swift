//
//  QuadraCoordenador.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation

//quadras do coordenandor
struct QuadraCoordenador: Codable, Identifiable {
    let id: String
    let nome: String
    let status: QuadraStatus
    let agenteNome: String? 
    
    
    enum QuadraStatus: String, Codable {
        case naoAtribuida
        case pendente
        case concluida
    }
}
