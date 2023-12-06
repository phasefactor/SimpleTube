//
// Overriding Youtube's e
//

Element.prototype._addEventListener = Element.prototype.addEventListener;

Element.prototype.addEventListener = function () {
    if (arguments[0] == "webkitpresentationmodechanged") {
        arguments[1] = (e) => {console.log("Not today, Satan!")};
    }
    
    return Element.prototype._addEventListener.apply(this, arguments);
};


