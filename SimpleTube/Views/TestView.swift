//
//  TestView.swift
//  SimpleTube
//
//  Created by Dustin on 9/25/23.
//

import SwiftUI
import WebKit

struct Webview : UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView?

    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }

    class Coordinator: NSObject, WKUIDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

        // Delegate methods go here

        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            // alert functionality goes here
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
        uiView.load(request)
    }

    func goBack(){
        webview?.goBack()
    }

    func goForward(){
        webview?.goForward()
    }

    func reload(){
        webview?.reload()
    }
}

#Preview {
    Webview(web: nil, req: URLRequest(url: URL(string:"https://www.google.com")!))
}
