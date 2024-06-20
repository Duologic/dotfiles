// ==UserScript==
// @name        Hit sign-in button on Drone
// @description Hit sign-in button on Drone
// @version     1.0
// @namespace   https://drone.grafana.net
// @match       https://drone.grafana.net/*
// @run-at      document-start
// @grant       none
// ==/UserScript==
(function() {
    'use strict';

    var waitForThatFrickingButton1 = setInterval(function() {
        let xpath = "//span[text()='Sign In']";
        let button = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        if(button) {
            button.click();
            clearInterval(waitForThatFrickingButton1);
        }
    }, 500)
    var waitForThatFrickingButton2 = setInterval(function() {
        let xpath = "//span[text()='Continue']";
        let button = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        if(button) {
            button.click();
            clearInterval(waitForThatFrickingButton2);
        }
    }, 500)
})();
