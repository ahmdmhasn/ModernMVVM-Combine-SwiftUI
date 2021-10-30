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
    
    /// Image
    ///
    var image: Image?
    
    /// Title text, Optional
    ///
    var titleText: String?
    
    /// Message text. Optional.
    ///
    var messageText: String?
    
    /// Button TItle. Button will be hidden if buttonTitle or buttonAction is nil.
    ///
    var buttonTitle: String?
    
    /// Button Action. Button will be hidden if buttonTitle or buttonAction is nil
    ///
    var buttonAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 150)
            }
            
            if let titleText = titleText {
                Text(titleText)
                    .font(.title2)
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
        PlaceholderView(image: Image(systemName: "rectangle.on.rectangle"),
                        titleText: "Error",
                        messageText: "Unable to load data", buttonTitle: "Button") { }
    }
}
