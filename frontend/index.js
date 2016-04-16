require('style!jss-lite!./styles');

const FontFaceObserver = require('fontfaceobserver');

// Prevent FOIT
const waitForMerriweather = new FontFaceObserver('Merriweather Light');
waitForMerriweather.check().then(() => {
  document.documentElement.setAttribute('data-fonts-loaded', '');
}).catch(() => {
  document.documentElement.setAttribute('data-fonts-failed-to-load', '');
});

// Wire things up
const Elm = require('./Main.elm');
const main = document.getElementById('main');
Elm.embed(Elm.Main, main, {
  initialPath: window.location.pathname,
});

// Offline installation
if ('serviceWorker' in navigator) {
  navigator.serviceWorker
    .register('/worker.js');
}

// Polyfills
require('scrollsnap-polyfill');
