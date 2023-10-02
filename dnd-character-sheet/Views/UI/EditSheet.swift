//
//  EditSheet.swift
//  dnd-character-sheet
//
//  Created by Benaja on 01.10.2023.
//

import SwiftUI

struct EditSheet<Sheet: View>: ViewModifier {
    @Binding var showSheet: Bool
    var applyChanges: () -> Void
    var presentationDetents: Set<PresentationDetent>?
    @ViewBuilder var sheet: Sheet


    
    func body(content: Content)-> some View {
        content
            .foregroundColor(.primary)
            .sheet(isPresented: $showSheet) {
            NavigationStack{
                sheet
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

extension View {
    func editSheet<Sheet: View>(
        isPresented: Binding<Bool>,
        applyChanges: @escaping () -> Void,
        presentationDetents: Set<PresentationDetent>? = nil,
        @ViewBuilder sheet: @escaping () -> Sheet
        ) -> some View {
        modifier(
            EditSheet(
                showSheet: isPresented,
                applyChanges: applyChanges,
                presentationDetents: presentationDetents,
                sheet: sheet
            ))
    }
}



#Preview {
    @State var showSheet = false
    
    return NavigationStack {
        VStack {
            Button (action: {
                showSheet = true
            }) {
                Text("Click me")
            }.editSheet(isPresented: $showSheet, applyChanges: {
                
            }) {
                Text("This is my content")
            }
            
        }
    }
}
