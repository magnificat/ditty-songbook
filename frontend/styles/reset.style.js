const c = require('./config');
const colors = require('material-colors');

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
    'font': 'inherit',
    'line-height': 'inherit',
  },

  [[
    'button',
    'button:focus',
    'button:active',
  ].join(', ')]: {
    'display': 'inline',
    'border': 'none',
    'background': 'none',
    'font-family': 'inherit',
    'cursor': 'pointer',
    'text-align': 'inherit',
  },

  [[
    'button::-moz-focus-inner',
  ].join(', ')]: {
    'border': 'none',
    'padding': '0',
  },

  ':focus': {
    'outline': `2px solid ${colors.cyan[500]}`,
  },
};
