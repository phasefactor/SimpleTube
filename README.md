# SimpleTube
Simple ad-free YouTube client.

All of YouTube's major functionality seems to work.  Known issues:
- Logging in works, but logging out seems to be broken.

---

The default cross-origin policies in `WKWebView` appear to block the loading of YouTube's advertisements.

YouTube would still make dozens of network requests to analytics/metrics APIs, etc.  They are being blocked by `WKContentRuleList` to reduce the network traffic.

---

Swiping to the left and right will navigate forward and backward. 
