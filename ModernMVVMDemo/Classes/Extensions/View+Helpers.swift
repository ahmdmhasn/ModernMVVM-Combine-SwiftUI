//
//  View+Helpers.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import SwiftUI

/// Handlers
/// 
extension View {
    
    /// Returns type-erased View
    ///
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Center View horizontally
    /// 
    func xCentered() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
