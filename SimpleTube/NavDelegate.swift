//
//  NavDelegate.swift
//  SimpleTube
//
//  Created by Dustin on 9/25/23.
//

import Foundation
import WebKit

class NavDelegate: NSObject, WKNavigationDelegate {
    var parent: WebView

    init(_ parent: WebView) {
        self.parent = parent
    }

    // Delegate methods go here
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        // alert functionality goes here
    }
}
