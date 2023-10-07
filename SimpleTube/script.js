(() => {
    // Handle swipes left and right to go back and forward
    document.body.addEventListener('touchstart', function (event) {
        touchStart = event.changedTouches[0].screenX;
    });

    document.body.addEventListener('touchend', function (event) {
        touchEnd = event.changedTouches[0].screenX;
        
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
    

    // this whole thing is gross.
    // using setInterval to avoid needing to get hooks into YouTube's dynamic page manipulation.
    // constantly overwriting onclick to avoid registering a bunch of listeners with addEventListener.
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

})();
