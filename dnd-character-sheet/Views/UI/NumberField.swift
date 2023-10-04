//
//  NumberField.swift
//  dnd-character-sheet
//
//  Created by Benaja on 30.09.2023.
//

import SwiftUI

struct NumberField:View {
    var label: String
    @Binding var value: Int?
    var minValue: Int? = nil
    var maxValue: Int? = nil
    
    init(_ label: String, value: Binding<Int?>, min: Int? = nil, max: Int? = nil) {
        self.label = label
        self._value = value
        self.minValue = min
        self.maxValue = max
    }
    var body: some View {
        HStack (alignment: .center) {
            TextField(label, text: Binding(
                get: { value != nil ? "\(value!)" : ""},
                set: { setValue(Int($0) ?? nil) }
            ))
            .keyboardType(.numberPad)
                .multilineTextAlignment(.leading)
//                .frame(height: 40)
                .onSubmit {
                    print("Text was submitted")
                }
                .submitLabel(.done)
            Spacer()
            Button(action: {
                setValue((value ?? 0) - 1)
            }) {
                Image(systemName: "minus")
            }
            .padding(.horizontal, 10)
            Button(action: {
                setValue((value ?? 0) + 1)
            }) {
                Image(systemName: "plus")
            }
        }
    }
    
    func setValue(_ value: Int?) {
        guard var value = value else {
            self.value = nil
            return
        }
        if self.minValue != nil {
            value = max(value, self.minValue!)
        }
        if self.maxValue != nil {
            value = min(value, self.maxValue!)
        }
        self.value = value
    }

}

#Preview {
    @State var value: Int? = 0;
    
    return NumberField("Type text here", value: $value)
}
