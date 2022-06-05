//
//  Modifiers.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 6/5/22.
//

import SwiftUI

// MARK: - VIEW MODIFIERS
struct MyTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title.bold())
    }
}
