//
//  EditSheet.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI

struct EditSheet<ButtonContent: View, Content: View>: View {
    @Binding var showSheet: Bool
    var applyChanges: () -> Void
    var presentationDetents: Set<PresentationDetent>?
    @ViewBuilder let button: ButtonContent
    @ViewBuilder let content: Content
    
    
    //    init(showSheet: Binding<Bool>, applyChanges: @escaping () -> Void,
    //         @ViewBuilder button: @escaping () -> Content,
    //         @ViewBuilder content: @escaping () -> Content) {
    //        self._showSheet = showSheet
    //        self.applyChanges = applyChanges
    //        self.button = button()
    //        self.content = content()
    //    }
    
    //    init(showSheet: Binding<Bool>, applyChanges: @escaping () -> Void, content: @escaping () -> some View) {
    //        self._showSheet = showSheet
    //        self.applyChanges = applyChanges
    //        self.content = content
    //    }
    
    var body: some View {
        Button(action: {
            showSheet = true
        }) {
            button
        }.foregroundColor(.primary)
            .sheet(isPresented: $showSheet) {
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
                .presentationDetents(presentationDetents ?? [])
            }
    }
}


#Preview {
    @State var showSheet = false
    
    return NavigationStack {
        VStack {
            
            EditSheet(showSheet: $showSheet, applyChanges: { print("applc changes")}, button: {
                Text("Button")
            }) {
                Text("Content")
            }.navigationTitle("Test")
        }
    }
}
