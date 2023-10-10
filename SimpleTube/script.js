(() => {
    // cleans up the stream of error messages in the console
    setTimeout(() => {
        if (yt) {
            // setting these null seems to stop the console spam
            yt.ads = null;
            yt.ads_ = null;
        }
    }, 2000);
    
   
    // this whole thing is gross.
    // Without a way to register callbacks in YouTube's dynamic page manipulation system we are stuck
    // using SetInterval and onclick as the easiest way to register an event listener that fires once.
    setInterval(() => {
        document.querySelectorAll("a").forEach((a) => {
            a.onclick = (ev) => {
                if (ev.target.tagName.toLowerCase() == "a") {
                    h = ev.target.href;
                    if (h.startsWith("https://www.youtube.com/redirect?")) {
                       window.location.href = (new URLSearchParams(h)).get("q");
                    }
                }
            };
        });
    }, 500);
    
    
    
    //
    // rolling our own (ugly) forward/backward swiping UI
    //
    let div = document.createElement("div");
    div.style.position = "fixed";
    div.style.top = 0;
    div.style.width = "0px";
    div.style.height = "100%";
    div.style.zIndex = 1000;
    div.style.backgroundColor = "grey";
    document.body.appendChild(div);
    
    let touchStart = 0;
    let touchEnd   = 0;
    let swiping    = false;
    
    // Handle swipes left and right to go back and forward
    document.body.addEventListener('touchstart', (event) => {
        touchStart = event.changedTouches[0].screenX;
        
        // only if we start near the edge of the screen
        if (touchStart < 25 || touchStart > (window.screen.width - 25)) {
            swiping = true;
        }
    });
    
    document.body.addEventListener('touchmove', (event) => {
        if (swiping) {
            let offset = event.changedTouches[0].screenX - touchStart;
            
            if (offset > 0) {
                div.style.left = 0;
                div.style.right = "";
            } else {
                div.style.left = "";
                div.style.right = 0;
            }
            
            div.style.width = "" + Math.abs(offset) + "px";
        }
        
    });

    document.body.addEventListener('touchend', (event) => {
        touchEnd = event.changedTouches[0].screenX;
        
        div.style.width = "0px";
        swiping = false;
        
        if (Math.abs(touchStart - touchEnd) > 200) {
            if (touchStart > touchEnd) {
                // left
                window.history.forward()
            } else {
                // right
                window.history.back()
            }
        }
    });
    
})();
