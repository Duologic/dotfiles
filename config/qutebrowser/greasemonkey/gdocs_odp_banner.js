// ==UserScript==
// @name        Hide ODP banner
// @description	Hides: File sensitivity label was applied to this file and set to Internal Use automatically
// @version		1.0
// @namespace   https://docs.google.com/
// @match       https://docs.google.com/document/*
// @match       https://docs.google.com/presentation/*
// @run-at      document-start
// @grant       none
// ==/UserScript==
(function() {
    'use strict';

    var waitForThatFrickingBanner = setInterval(function() {
        let xpath = "//div[contains(@class, 'docs-odp-banner-container')]";
        let banner = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        if(banner) {
            banner.remove();
            clearInterval(waitForThatFrickingBanner);
        }
    }, 500)
})();
