//
//  TubeView.swift
//  SimpleTube
//
//  Created by phasefactor on 9/25/23.
//

import SwiftUI
import WebKit


struct TubeView: UIViewRepresentable {
    // defined below
    @State var navDel = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        // Needed for the auto-play of video previews to not instantly enter full-screen.
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        //
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // Assign the NavigationDelegate
        webView.navigationDelegate = navDel
        
        
        webView.allowsBackForwardNavigationGestures = true
        
        // Allow Safari developer tools to connect to the app for debugging
        webView.isInspectable = true
        
        return webView
    }
    
    
    
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: "https://www.youtube.com")!)
        
        webView.load(request)
    }
    
    
    
    
    
    class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            decisionHandler(.allow)
            return

   //         if let host = navigationAction.request.url?.host {
   //             if host.contains("youtube.com") {
   //                let _ = print("ALLOWED: " + String(navigationAction.request.url?.host ?? "null"))

    //                decisionHandler(.allow)
    //                return
    //            }
    //        }
    //        let _ = print("DENIED: " + String(navigationAction.request.url?.host ?? "null"))
            
    //        decisionHandler(.cancel)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

            
             decisionHandler(.allow)
        }
    }
}


#Preview {
    VStack {
        TubeView()
    }
}
