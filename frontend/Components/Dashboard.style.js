const u = require('../styles/utils');
const c = require('../styles/config');

const dashboardPadding = 20;

const categoryBorderWidth = 1;
const categoryBorder =
  `${categoryBorderWidth}px solid currentColor`;

module.exports = {
  '.dashboard': {
    'padding': u.inRem(dashboardPadding),
    'width': u.inRem(c.navBarWidth),
    'height': '100%',
    'background': [
      'url(/images/background.jpg)',
      'url(/images/background.prerender.png)',
    ].join(','),
    'background-size': 'cover',
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
  },

  '.dashboard’s-category': {
    'position': 'relative',
    'line-height': u.inRem(40),
    'padding': [
      u.inRem(10),
      '0',
    ].join(' '),
  },

  '.dashboard’s-category::before': {
    'content': '" "',
    'display': 'block',
    'position': 'absolute',
    'top': u.inRem(5),
    'bottom': u.inRem(5),
    'left': u.inRem(-dashboardPadding),
    'width': u.inRem(5),
    'background': 'rgba(0, 0, 0, 0.5)',
  },
};
