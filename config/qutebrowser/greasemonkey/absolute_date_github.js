
// ==UserScript==
// @name         Github: Always show absolute times
// @author       me
// @match        https://github.com/*
// @run-at       document-end
// ==/UserScript==

console.log('Github: Always show absolute times');

// Docs for relative-time: https://github.com/github/relative-time-element
function showAbsolute(node) {
    node.querySelectorAll("relative-time").forEach(function(el) {
        if (el.tense == 'past') {
            el.format = 'datetime';
            el.formatStyle = 'long';
            el.weekday = '';
            el.year = 'numeric';
            el.month = '2-digit';
            el.day = '2-digit';
            el.hour = '2-digit';
            el.minute = '2-digit';
            el.lang = 'en-IE';
            el.style.marginLeft = '-10px';
        }
    });
}

const selector = 'relative-time';

function callback(mutationList, observer) {
    mutationList.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
            if (node.querySelectorAll && node.querySelectorAll(selector)) {
                showAbsolute(node)
                console.log('found relative time');
            }
        })
    });
}

const observer = new MutationObserver(callback);

observer.observe(document.body, {
    childList: true,
    subtree: true,
    attributes: true,
});
