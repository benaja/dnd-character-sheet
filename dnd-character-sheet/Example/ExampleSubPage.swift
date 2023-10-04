//
//  ExampleSubPage.swift
//  dnd-character-sheet
//
//  Created by Benaja on 04.10.2023.
//

import SwiftUI

struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 5) {
            configuration.icon
                .font(.title2)
            configuration.title
                    .font(.caption)
        }
        .padding(.top, 5)
    }
}

struct ExampleSubPage: View {
    var body: some View {
        CustomTabView{
            Text("Test")
                .customTabItem(Label("Stats", systemImage: "chart.bar.fill"))
        }
//        VStack {
//            ScrollView {
//                ForEach(0 ..< 40) { item in
//                    Text("hey there")
//                }
//            }.frame(maxWidth: .infinity)
//            
//            Spacer()
//            
//            
//            HStack {
//                Button (action: {}) {
//                    Label("Stats", systemImage: "chart.bar.fill")
//                }.frame(maxWidth: .infinity)
//                Button(action: {}) {
//                    Label("Inventory", systemImage: "backpack.fill")
//                }.frame(maxWidth: .infinity)
//                    .foregroundColor(.gray)
//                
//                //                            Label("Combat", systemImage: "xmark.shield")
//                //                            Label("Spells", systemImage: "flame")
//                //                            Label("Character", systemImage: "figure.stand")
//            }.frame(maxWidth: .infinity)
//                .labelStyle(CustomLabelStyle())
//                .background(Color(UIColor.systemGray6))
//        }
//        .navigationTitle("My Stack")
    }
}

#Preview {
    ExampleSubPage()
}
