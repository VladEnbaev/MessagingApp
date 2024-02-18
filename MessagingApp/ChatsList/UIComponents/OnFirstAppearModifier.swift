//
//  OnFirstAppearModifier.swift
//
//
//  Created by Vlad Developer on 09.12.2023.
//

import SwiftUI


public extension View {
    func onFirstAppear(
        _ action: @escaping () -> ()
    ) -> some View {
        self.modifier(FirstAppear(firstAppearAction: action))
    }
    
    func onAppear(
        firstAppearAction: @escaping () -> Void,
        reAppearAction: @escaping () -> Void
    ) -> some View {
        self.modifier(FirstAppear(firstAppearAction: firstAppearAction, reAppearAction: reAppearAction))
    }
}

private struct FirstAppear: ViewModifier {
    let firstAppearAction: () -> Void
    let reAppearAction: () -> Void
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    init(firstAppearAction: @escaping () -> Void, reAppearAction: @escaping () -> Void = {}) {
        self.firstAppearAction = firstAppearAction
        self.reAppearAction = reAppearAction
    }
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                firstAppearAction()
            } else {
                reAppearAction()
            }
        }
    }
}

