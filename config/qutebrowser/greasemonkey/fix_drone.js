// ==UserScript==
// @name         Remove _blank targets
// @description  Remove _blank targets
// @author       me
// @include      https://drone.grafana.net/*
// @version      1.0.0
// @run-at       document-idle
// ==/UserScript==

console.log("starting for drone");

setInterval(function(){
var links = document.getElementsByTagName('a')
console.log("Fixing " + links.length + " links.")
for (i=0;i<links.length; i++) {
    var link = links[i];
    if (link.target == "_blank") {
        link.removeAttribute('target');
    }
}}, 1000)
