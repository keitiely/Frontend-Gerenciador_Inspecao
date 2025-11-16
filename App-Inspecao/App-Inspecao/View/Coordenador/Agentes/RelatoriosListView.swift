//
//  RelatoriosListView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import SwiftUI

public struct RelatoriosListView: View {
    let quadra: Quadra

//    public init(quadra: Quadra) {
//        self.quadra = quadra
//    }

    public var body: some View {
        Text("Relatorios das quadras \(quadra.id)")
    }
}
