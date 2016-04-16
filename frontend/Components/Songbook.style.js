const u = require('../styles/utils');
const c = require('../styles/config');
const colors = require('material-colors');

module.exports = {
  '.songbook': {
    'font-size': u.inRem(18),
    'line-height': u.inRem(c.lineHeight),
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

  '.songbook’s-background': {
    'background-color': '#d5dbdb',
  },
};
