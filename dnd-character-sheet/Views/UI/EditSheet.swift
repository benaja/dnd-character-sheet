//
//  EditSheet.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI

struct EditSheet<Content: View>: View {
    @Binding var showSheet: Bool
    var applyChanges: () -> Void
    @ViewBuilder let content: Content
    
//    init(showSheet: Binding<Bool>, applyChanges: @escaping () -> Void, content: @escaping () -> some View) {
//        self._showSheet = showSheet
//        self.applyChanges = applyChanges
//        self.content = content
//    }
    
    var body: some View {
        NavigationStack{
            content
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .toolbar() {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Apply") {
                            applyChanges()
                        }
                    }
                }
        }
            
    }
}

#Preview {
    @State var showSheet = false
    
    return NavigationStack {
        VStack {
            Button(action: {
                showSheet = true
            }) {
                Text("ShowSheet")
            }.sheet(isPresented: $showSheet) {
                EditSheet(showSheet: $showSheet, applyChanges: { print("applc changes")}) {
                    Text("Content")
                }.navigationTitle("Test")
            }
        }
    }
}
