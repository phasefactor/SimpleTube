

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
