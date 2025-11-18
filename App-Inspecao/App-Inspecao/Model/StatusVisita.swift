//
//  StatusVisita.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import Foundation

// 1. Adicionamos 'CaseIterable' e 'Identifiable'
//    para o Picker do SwiftUI funcionar facilmente.
enum StatusVisita: String, Codable, CaseIterable, Identifiable {
    
    // Os 'rawValues' são o que recebemos da API (listagem)
    case concluida = "CONCLUIDA"
    case pendente = "PENDENTE"
    
    // Vamos adicionar os outros casos que podemos ENVIAR
    case recusada = "RECUSADA"
    
    case unknown = "UNKNOWN"

    // 2. Necessário para 'Identifiable'
    var id: Self { self }

    // 3. Texto que o usuário verá no seletor (Picker)
    var displayName: String {
        switch self {
        case .concluida:
            return "Visita Concluída (Aceita)"
        case .pendente:
            return "Morador Ausente"
        case .recusada:
            return "Visita Recusada"
        case .unknown:
            return "Desconhecido"
        }
    }

    // 4. "Tradutor" para o JSON que vamos ENVIAR para o backend
    //    (Isso deve bater com o que o 'inspecoes.controller.js' espera)
    var valorParaBackend: String {
        switch self {
        case .concluida:
            return "aceita"
        case .pendente:
            return "morador_ausente"
        case .recusada:
            return "recusada"
        default:
            return "morador_ausente" // Um padrão seguro
        }
    }

    // O init que você já tinha
    public init(from decoder: Decoder) throws {
        self = try StatusVisita(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .unknown
    }
}
