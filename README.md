# SimpleTube
Simple ad-free YouTube client.

The default cross-origin policies in `WKWebView` appear to block the loading of YouTube's advertisements.

YouTube still makes dozens of network requests to analytics/metrics APIs, etc.  So this overwrites the `XMLHttpRequest` object and removes some of the other scripts.

All of YouTube's major functionality seems to still work.  

I may update with swiping left/right for back/forward navigation. 
