const u = require('../styles/utils');
const c = require('../styles/config');

const grabZoneWidth = 30;
const relativeLineHeight = 1.8;
const fontToScreenWidth = 2.5;
const minFontSizeInPx = 18;
const lineContinuationIndent = 4;

module.exports = {
  [[
    '.display’s-wrapper',
    '.display',
  ]]: {
    'position': 'absolute',
    'top': '0',
    'width': '100%',
  },

  '.display’s-wrapper': {
    'left': '0',
    'height': '100%',
    'overflow-x': 'scroll',
    'overflow-y': 'auto',
  },

  [[
    '.display’s-wrapper',
  ].map(selector => `${selector}::-webkit-scrollbar`).join(', ')]: {
    'display': 'none',
  },

  '.display': {
    'z-index': `${c.zIndex.display}`,
    'pointer-events': 'auto',
    'min-height': '100%',
    'left': u.inRem(c.dashboardWidth),
    'padding': `${relativeLineHeight / 2}em`,
    'background': 'black',
    'box-shadow': '1px 0 0 1px black',
      // Prevents subpixel rounding artifacts on edges.
    'color': u.whiteOpacity(1),
    'line-height': `${relativeLineHeight}`,
    'font-size': `${fontToScreenWidth}vw`,
  },

  [`@media screen and (max-width: ${
    minFontSizeInPx / fontToScreenWidth * 100
  }px)`]: {
    '.display': {
      'font-size': `${minFontSizeInPx}px`,
    },
  },

  '.display::before': {
    'display': 'block',
    'content': '""',
    'position': 'absolute',
    'top': '0',
    'left': '0',
    'bottom': '0',
    'right': '0',
    'box-shadow': [
      u.inRem(c.displayShadowBlur),
      '0',
      u.inRem(c.displayShadowBlur),
      u.inRem(c.displayShadowBlur),
      'black',
    ].join(' '),
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

  '.display’s-song-line': {
    'padding-left': `${lineContinuationIndent}em`,
    'text-indent': `${-lineContinuationIndent}em`,
  },
};
