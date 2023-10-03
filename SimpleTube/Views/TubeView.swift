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
        let webConfiguration = WKWebViewConfiguration()
        
        // Needed for the auto-play of video previews to not instantly enter full-screen.
        webConfiguration.allowsInlineMediaPlayback = true
        
        // Setup a content controller so that we can inject JS to the WKWebView
        let contentController = WKUserContentController()
        
        let source = """
            // Effectively turns off all the background requests; null also works.
            XMLHttpRequest = function () { return new Object(); };
                
            addEventListener("DOMContentLoaded", (e) => {
                document.body.querySelectorAll("script").forEach((s) => {
        
                    // might be pointless.
                    // some number of these scripts will have already run
                    if (!s.src || !s.src.includes("youtube.com")) {
                        s.remove();
                    }
                });
            });
            
            // fires after DOMContentLoaded, pages should be fully loaded
            addEventListener("load", (e) => {
                document.body.querySelectorAll("script").forEach((s) => {
        
                    // might be pointless.
                    // some number of these scripts will have already run
                    if (!s.src || !s.src.includes("youtube.com")) {
                        s.remove();
                    }
                });
        
                // removes "open in app" button
                var styleSheet = document.createElement("style")
                styleSheet.innerText = "div.mobile-topbar-header-content > ytm-button-renderer { display: none; }";
                document.head.appendChild(styleSheet)
            });
        
        """

        let script = WKUserScript(source: source,
                                  injectionTime: .atDocumentStart,
                                  forMainFrameOnly: true)
        
        contentController.addUserScript(script)
        
        // Attach the content controller to the configuration
        webConfiguration.userContentController = contentController
        
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
        
        
        
        webView.allowsBackForwardNavigationGestures = true
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
