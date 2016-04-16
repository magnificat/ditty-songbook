const u = require('../styles/utils');
const c = require('../styles/config');

const grabZoneWidth = 30;

module.exports = {
  [[
    '.display’s-wrapper',
    '.display',
  ]]: {
    'position': 'absolute',
    'top': '0',
    'height': '100%',
    'width': '100%',
  },

  '.display’s-wrapper': {
    'left': '0',
    'overflow-x': 'scroll',
    'overflow-y': 'hidden',
  },

  '.display’s-wrapper::-webkit-scrollbar': {
    'display': 'none',
  },

  '.display': {
    'z-index': `${c.zIndex.display}`,
    'pointer-events': 'auto',
    'left': u.inRem(c.dashboardWidth),
    'padding': '1em',
    'background': 'black',
    'box-shadow': '1px 0 0 1px black',
      // Prevents subpixel rounding artifacts on edges.
    'color': u.whiteOpacity(1),
  },

  '.display::before': {
    'display': 'block',
    'content': '""',
    'position': 'absolute',
    'top': u.inRem(-c.displayShadowBlur),
    'left': '0',
    'bottom': u.inRem(-c.displayShadowBlur),
    'right': '0',
    'box-shadow': `0 0 ${u.inRem(c.displayShadowBlur)} black`,
  },

  '.display::after': {
    'display': 'block',
    'content': '""',
    'position': 'absolute',
    'top': '0',
    'left': u.inRem(-grabZoneWidth),
    'bottom': '0',
    'width': u.inRem(grabZoneWidth),
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
