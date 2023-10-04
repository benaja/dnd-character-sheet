//
//  Example.swift
//  dnd-character-sheet
//
//  Created by Benaja on 04.10.2023.
//

import SwiftUI



struct Example: View {
    
    var body: some View {
        NavigationStack{
            List(0 ..< 40) { item in
                NavigationLink(destination: {
                    
//                    TabView {
//                        List(0 ..< 20) { child in
//                            NavigationLink(destination: {
//                                Text("nested")
//                            }) {
//                                Text("Child \(child)")
//                                
//                            }
//                        }.tabItem {
//                            Text("Tab 1")
//                        }
//                        
//                        List(0 ..< 20) { child in
//                            Text("Child \(child)")
//                        }.tabItem {
//                            Text("Tab 1")
//                        }
//                    }
//                    .navigationTitle("Hey")
                        
                        
                    
                }) {
                    Text("Item \(item)")
                    
                }
            }
            .navigationTitle("Main Page")
        }
    }
}

#Preview {
    Example()
}
