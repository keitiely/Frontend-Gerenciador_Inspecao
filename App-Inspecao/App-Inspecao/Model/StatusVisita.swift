//
//  StatusVisita.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation

enum StatusVisita: String, Codable, CaseIterable {
    case pendente = "PENDENTE"
    case concluida = "CONCLUIDA"
    
    case unknown = "UNKNOWN"

    public init(from decoder: Decoder) throws {
        self = try StatusVisita(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .unknown
    }
}
