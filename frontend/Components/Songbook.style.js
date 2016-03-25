const u = require('../styles/utils');
const c = require('../styles/config');
const colors = require('material-colors');

module.exports = {
  '.songbook': {
    'position': 'relative',

    'width': '100%',
    'height': '100%',
    'overflow': 'hidden',
    'line-height': u.inRem(c.lineHeight),

    'background-color': '#d5dbdb',
    'font-size': u.inRem(18),
    'font-family': 'serif',
    'color': u.primaryColorOpacity(c.opacityBeforeFontsLoaded),
  },

  '[data-fonts-loaded] .songbook': {
    'font-family': '"Merriweather Light", serif',
  },

  [[
    '[data-fonts-loaded] .songbook',
    '[data-fonts-failed-to-load] .songbook',
  ].join(', ')]: {
    'color': u.primaryColorOpacity(1),
  },

  '.songbook a:not([class])': {
    'color': colors.cyan[700],
  },
};
