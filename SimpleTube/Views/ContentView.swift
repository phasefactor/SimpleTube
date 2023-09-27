//
//  ContentView.swift
//  SimpleTube
//
//  Created by phasefactor on 9/25/23.
//

import SwiftUI

struct ContentView: View {
//    @State var urlTextField: String = "https://www.google.com"
//    @State var url: URL? = URL(string: "")

    
    var body: some View {
//        VStack {
            WebView(url: URL(string: "https://www.youtube.com"))
//            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(.secondary, lineWidth: 2)
//            )
//            .onAppear{
                
//            }
            
//            HStack {
//                TextField("URL", text: $urlTextField)
//                    .frame(width:nil)
//                   .textFieldStyle(RoundedBorderTextFieldStyle())
             
//                Button("Go") {
//                    url = URL(string: urlTextField)
//                }
//                .padding()
//            }
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
