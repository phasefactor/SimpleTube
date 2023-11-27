//
//  TubeView.swift
//  SimpleTube
//
//  Created by phasefactor on 9/25/23.
//

import SwiftUI
import WebKit


struct TubeView: UIViewRepresentable {
    let navDel = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let config  = WKWebViewConfiguration()
        let control = WKUserContentController()

        config.userContentController = control
        
        // Needed for the auto-play of video previews to not instantly enter full-screen.
        config.allowsInlineMediaPlayback = true
        
        var source = "console.log('failed to load script.js');"
        
        do {
            source = try String(contentsOf: Bundle.main.url(forResource: "script", withExtension: "js")!)
        } catch {}

        let script = WKUserScript(source: source,
                                  injectionTime: .atDocumentEnd,
                                  forMainFrameOnly: true)
        
        control.addUserScript(script)
        
        // add block rules as described:
        // https://developer.apple.com/documentation/safariservices/creating_a_content_blocker
        
        // list of domains/URLs that YouTube sends/loads nonsense to/from
        let urlList = ["doubleclick.net", "googlesyndication.com", "googleapis.com", "youtube.com/api/stats/", "youtube.com/generate_204", "play.google.com/log", "youtube.com/ptracking"]
        
        // Still loading scripts from:
        // - m.youtube.com/s/_/ytmweb/
        // - www.google.com/js/th/
        // - m.youtube.com/s/player/
        // - m.youtube.com/static/r/     (search suggestions)
        
        // build our JSON block list from scratch
        var jsonString = "["
        
        for url in urlList {
            jsonString += "{\"trigger\":{\"url-filter\":\".*\(url.replacingOccurrences(of: ".", with: "\\\\.")).*\"},\"action\":{\"type\":\"block\"}},"
        }
        
        // CSS rule to hide the "Get App" button
        jsonString += "{\"trigger\":{\"url-filter\":\".*\"},\"action\":{\"type\":\"css-display-none\",\"selector\":\".open-app-button,ytm-statement-banner-renderer\"}}"
        
        jsonString += "]"
        
        // compile the rules list
        WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "ContentBlockingRules", encodedContentRuleList: jsonString) { (contentRuleList, error) in
                
            if error != nil {
                let _ = print("ERROR: creating rule list!!!\n ", error as Any)
                
                return
            }
            
            // attach compiled rules to config
            config.userContentController.add(contentRuleList!)
        }
        
        // create the actual WKWebView
        let webView = WKWebView(frame: .zero, configuration: config)
        
        // Assign the NavigationDelegate
        webView.navigationDelegate = navDel
        
        // Allow Safari developer tools to connect to the app for debugging
        webView.isInspectable = true
        
        return webView
    }
    
    
    
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: "https://m.youtube.com/?persist_app=1&app=m")!)
        
        webView.load(request)
    }
    
    
    
    
    
    class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            if let url = navigationAction.request.url {
                if let host = url.host {
                    
                    if navigationAction.navigationType == .linkActivated {
                        let _ = print("link")
                    }
                    
                    let _ = print("navigating to", host)
                    if host.contains("youtube.com") || host.contains("accounts.google.co") {
                            decisionHandler(.allow)
                            return
                    } else {
                        // open external links in default browser
                        UIApplication.shared.open(url)
                    }
                }
            }
                
                decisionHandler(.cancel)
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
