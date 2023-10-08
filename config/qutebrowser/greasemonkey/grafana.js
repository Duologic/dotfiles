// ==UserScript==
// @name         Set fixed width on time/nav
// @description  Set fixed width on time/nav
// @author       me
// @include      https://admin-*.grafana.net/*
// @version      1.0.0
// @run-at       document-end
// ==/UserScript==

console.log("starting for grafana");

function waitForElm(selector) {
    return new Promise(resolve => {
        if (document.querySelector(selector)) {
            return resolve(document.querySelector(selector));
        }

        const observer = new MutationObserver(mutations => {
            if (document.querySelector(selector)) {
                resolve(document.querySelector(selector));
                observer.disconnect();
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    });
}

waitForElm('.css-63jktz').then((elm) => {
    elm.style.minWidth="500px";
})
