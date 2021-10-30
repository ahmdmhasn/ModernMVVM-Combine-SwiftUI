//
//  Spinner.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import UIKit
import SwiftUI

/// Spinner View
///
struct Spinner {
        
    var isAnimating: Binding<Bool>
    let color: UIColor
    let style: UIActivityIndicatorView.Style
    
    init(isAnimating: Binding<Bool> = .constant(true),
         color: UIColor = .gray,
         style: UIActivityIndicatorView.Style = .medium) {
        self.isAnimating = isAnimating
        self.color = color
        self.style = style
    }
}

/// UIViewRepresentable
///
extension Spinner: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.color = color
        view.hidesWhenStopped = true
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating.wrappedValue {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner(isAnimating: .constant(true), style: .medium)
    }
}
