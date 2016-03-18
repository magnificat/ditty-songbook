const u = require('../styles/utils');

const dashboardPadding = 20;

const categoryBorderWidth = 1;
const categoryBorder =
  `${categoryBorderWidth}px solid rgba(255, 255, 255, .2)`;

module.exports = {
  '.dashboard': {
    'padding': u.inRem(dashboardPadding),
  },

  '.dashboard’s-title': {
    'font-size': u.inRem(40),
    'line-height': u.inRem(40),
  },

  '.dashboard’s-subtitle': {
    'font-size': u.inRem(12),
    'text-transform': 'uppercase',
    'letter-spacing': '0.2em',
  },

  '.dashboard’s-categories': {
    'list-style-type': 'none',
    'padding-top': u.inRem(40),
    'margin': `0 ${u.inRem(-dashboardPadding)}`,
    'border-bottom': categoryBorder,
  },

  '.dashboard’s-category': {
    'line-height': u.inRem(40),
    'padding': [
      u.inRem(10 - categoryBorderWidth / 2),
      u.inRem(20),
    ].join(' '),
    'border-top': categoryBorder,
  },
};
