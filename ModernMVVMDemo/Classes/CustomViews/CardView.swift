//
//  CardView.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import SwiftUI

struct CardView<Content>: View where Content: View {
    
    @ViewBuilder let content: Content
    var padding: CGFloat = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 2)
            
            content
                .padding(padding)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Hello, World!")
        }
    }
}
