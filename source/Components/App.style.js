const u = require('../styles/utils');
const c = require('../styles/config');

module.exports = {
  '.app': {
    'position': 'relative',

    'width': '100%',
    'height': '100%',

    'font-size': u.inRem(18),
    'font-family': '"Merriweather Light", serif',
    'line-height': u.inRem(30),
    'color': 'white',
    'background-color': c.appBackground,
  },
};
