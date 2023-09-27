//
//  WebView.swift
//  SimpleTube
//
//  Created by Dustin on 9/25/23.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    var url: URL? = nil
    var html: String = ""
    
    init(url: URL? = nil, html: String) {
        self.url = url
        self.html = html
    }
 
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        
        webView.isInspectable = true
        
        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        if url != nil {
            let _ = print("webview - " + url!.host()! )
            
            let request = URLRequest(url: url!)
            
            webView.load(request)
        } else {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}


#Preview {
    VStack {
        WebView(url: URL(string:"https://www.youtube.com")!)
        if false {
            Spacer()
            WebView(html: """
                        <html>
                          <head>
                            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
                          </head>
                          <body>
                            <p>Some HTML!</p>
                          </body>
                        </html>
                        """)
            Spacer()
            WebView()
        }
    }
}
