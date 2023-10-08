// ==UserScript==
// @name         Github: Disable codeview Textarea
// @author       me
// @match        https://*.github.com/*
// @run-at       document-end
// ==/UserScript==

console.log('Github: Disable codeview Textarea');

const selector = '#read-only-cursor-text-area';

function callback(mutationList, observer) {
    mutationList.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
            if (node.querySelector && node.querySelector(selector)) {
                node.querySelector(selector).disabled=true;
                console.log('disabled textarea');
            }
        })
    });
}

const observer = new MutationObserver(callback);

observer.observe(document.body, {
    childList: true,
    subtree: true
});
