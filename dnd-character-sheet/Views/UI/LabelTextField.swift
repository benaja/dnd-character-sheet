//
//  LabelTextField.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

struct LabelTextField: View {
    let placeholder: String
    let label: String?
    @Binding var value: String
    @FocusState var isFocused: Bool
    
    let alignment: HorizontalAlignment
    let textFont: Font
    
    var body: some View {
        VStack (alignment: alignment, spacing: 0) {
            if (label != nil) {
                Text(label!)
                    .font(.caption)
            }
            TextField(placeholder, text: $value)
                .focused($isFocused)
                .font(textFont)
                .multilineTextAlignment(alignment == .leading ? .leading : .center)
        }.onTapGesture {
            isFocused = true
        }
    }
    
    init(_ label: String?, 
         value: Binding<String>,
         placeholder: String = "Enter text...",
         alignment: HorizontalAlignment = .leading,
         textFont: Font = .body
    ) {
        self.label = label
        self._value = value
        self.placeholder = placeholder
        self.alignment = alignment
        self.textFont = textFont
    }
}


#Preview {
    @State var text: String = ""
    
    return LabelTextField("Label", value: $text, placeholder: "Type some Text")
}
