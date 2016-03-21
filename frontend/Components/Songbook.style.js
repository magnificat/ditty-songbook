const u = require('../styles/utils');

module.exports = {
  '.songbook': {
    'position': 'relative',

    'width': '100%',
    'height': '100%',
    'overflow': 'hidden',
    'line-height': u.inRem(30),

    'background-color': '#d5dbdb',
    'font-size': u.inRem(18),
    'font-family': 'serif',
    'color': 'rgba(0, 0, 0, 0.4)',
  },

  '[data-fonts-loaded] .songbook': {
    'font-family': '"Merriweather Light", serif',
    'color': 'rgba(0, 0, 0, 0.87)',
  },
};
