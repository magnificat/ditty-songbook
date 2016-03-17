require('style!jss-lite!./styles');

const Elm = require('./Main.elm');

const main = document.getElementById('main');
Elm.embed(Elm.Main, main);
