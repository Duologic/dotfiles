// ==UserScript==
// @name        Slack
// @description Configure Slack things
// @namespace   https://app.slack.com/
// @match       https://*.slack.com/*
// @match       https://*.slack-edge.com/*
// ==/UserScript==

//(function() {
//    'use strict';
//
//    const navigator = window.navigator;
//    const modifiedNavigator = Navigator.prototype;
//
//    Object.defineProperties(modifiedNavigator, {
//        userAgent: {
//            //value: navigator.userAgent + ' CrOS',
//            value: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/118.0',
//            configurable: false,
//            enumerable: true,
//            writable: false
//        },
//    });
//    // See:
//    // https://webapps.stackexchange.com/questions/144258/slacks-web-version-shows-workspace-switching-sidebar-but-only-on-chromebooks
//    //
//    //Object.defineProperty(navigator, 'userAgent', {
//    //  // This seems to be the minimal change to make Slack detect Chrome OS, as of 2020-09-25:
//    //  //value: 'Mozilla/5.0 (X11; CrOS x86_64 14388.61.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.107 Safari/537.36'
//    //  // Updated to match Qutebrowser UA - since 2023-05-24
//    //    value: 'Mozilla/5.0 (X11; CrOS x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/6.5.0 Chrome/108.0.5359.220 Safari/537.36'
//    //  //value: navigator.userAgent + ' CrOS'
//    //});
//
//})();

(function() {
    'use strict';
    let localConfig = localStorage.getItem("localConfig_v2");
    if (localConfig) {
        localConfig = localConfig.replace(/\"is_unified_user_client_enabled\":false/g, '\"is_unified_user_client_enabled\":true');
        //localConfig = localConfig.replace(/\"viewLayoutIsWorkspaceSwitcherVisible\":false/g, '\"viewLayoutIsWorkspaceSwitcherVisible\":true');
        localStorage.setItem("localConfig_v2", localConfig);
    }
})();
