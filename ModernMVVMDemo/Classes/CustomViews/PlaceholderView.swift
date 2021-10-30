//
//  PlaceholderView.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import SwiftUI

/// Placeholder view with title, message and action
///
struct PlaceholderView: View {
    
    var imageName: String?
    var titleText: String?
    var messageText: String?
    var buttonTitle: String?
    var buttonAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 150)
            }
            
            if let titleText = titleText {
                Text(titleText)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            
            if let messageText = messageText {
                Text(messageText)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            
            if let buttonTitle = buttonTitle,
               let buttonAction = buttonAction {
                Button(buttonTitle,
                       action: buttonAction)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(imageName: "rectangle.on.rectangle",
                        titleText: "Error",
                        messageText: "Unable to load data", buttonTitle: "Button") { }
    }
}
