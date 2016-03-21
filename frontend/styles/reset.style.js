const c = require('./config');

module.exports = {
  [`@media screen and (max-width: ${c.navBarViewportWidth}px)`]: {
    'html': {
      'font-size': `${16 / c.navBarViewportWidth * 100}vw`,
    },
  },

  '@-ms-viewport': {
    'width': 'device-width',
  },

  'html, body, #main': {
    'width': '100%',
    'height': '100%',
  },

  '*, *::before, *::after': {
    'margin': '0',
    'padding': '0',
    'box-sizing': 'border-box',
    'font-family': 'inherit',
    'font-weight': 'inherit',
    'line-height': 'inherit',
  },
};
