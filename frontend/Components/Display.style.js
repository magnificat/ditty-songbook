const u = require('../styles/utils');
const c = require('../styles/config');

const shadowBlur = 20;

module.exports = {
  '.display': {
    'position': 'absolute',
    'top': '0',
    'left': u.inRem(c.navBarWidth),
    'height': '100%',
    'width': '100%',
    'background': 'black',
    'color': 'white',
  },

  '.display::before': {
    'display': 'block',
    'content': '" "',
    'position': 'absolute',
    'top': u.inRem(-shadowBlur),
    'left': '0',
    'bottom': u.inRem(-shadowBlur),
    'right': '0',
    'box-shadow': `0 0 ${u.inRem(shadowBlur)} black`,
  },
};
