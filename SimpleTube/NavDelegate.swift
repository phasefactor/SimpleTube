//
//  NavDelegate.swift
//  SimpleTube
//
//  Created by phasefactor on 9/25/23.
//

import Foundation
import WebKit

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if let host = navigationAction.request.url?.host {
            if host.contains("youtube.com") {
                decisionHandler(.allow)
                return
            }
        }
        // decisionHandler(.allow)
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        
         decisionHandler(.allow)
    }
}
