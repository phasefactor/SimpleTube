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
            var _XMLHttpRequest = XMLHttpRequest;
        
            XMLHttpRequest = function() {
                var xhr = new _XMLHttpRequest();

                var _open = xhr.open;
        
                xhr.open = function() {
                    console.log("XMLHttpRequest for: " + arguments[1]);
                    arguments[1] = "0.0.0.0";
                    return _open.apply(this, arguments);
                }

               // return xhr;
                // interestingly this does not break the site...
                return null;
            }
        
            document._createElement = document.createElement;
        
            document.createElement = function() {
             //   console.log("createElement: " + arguments[0]);
                
                if (arguments[0].toLowerCase() == "iframe") {
                    const i = document._createElement("iframe");
        
                    const handleLoad = () => console.log('loaded');
                    i.addEventListener('load', handleLoad, true);
                            
                    const handleChange = () => console.log('changed');
                    i.addEventListener('change', handleChange, true);
        
                    return i;
                } else {
                    return document._createElement(arguments[0]);
                }
            }
                
            console.log("1");
            
            addEventListener("DOMContentLoaded", (event) => {console.log("2");});
        
            // due to injectionTime = .atDocumentStart there is no document.body yet...
            console.log(document.body);
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
