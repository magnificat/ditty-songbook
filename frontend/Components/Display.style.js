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
    'padding': '1em',
    'background': 'black',
    'color': u.whiteOpacity(1),
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

  '[data-fonts-loaded] .display': {
    'color': u.whiteOpacity(1),
  },

  '.display’s-song-block': {
    'margin-bottom': u.inRem(c.lineHeight),
  },

  '.display’s-song-block·type»refrain': {
    'font-style': 'italic',
  },
};
