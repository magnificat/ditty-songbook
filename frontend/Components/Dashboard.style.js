const u = require('../styles/utils');
const c = require('../styles/config');
const colors = require('material-colors');

const dashboardPadding = 20;
const halfCategorySpacing = 5;
const categoryBorderWidth = 5;

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
    'line-height': u.inRem(40),
    'position': 'relative',
    'margin': [
      '0',
      u.inRem(-dashboardPadding),
      u.inRem(halfCategorySpacing * 2),
    ].join(' '),
  },

  '.dashboard’s-category·unfolded': {
    'background': 'red',
  },

  [[
    '.dashboard’s-button',
    '.dashboard’s-button:focus',
  ].join(', ')]: {
    'display': 'block',
    'width': '100%',
    'padding': [
      '0',
      u.inRem(dashboardPadding),
      '0',
      u.inRem(dashboardPadding - categoryBorderWidth),
    ].join(' '),
    'border-left': [
      u.inRem(categoryBorderWidth),
      'solid',
      u.primaryColorOpacity(0.7),
    ].join(' '),
  },

  '.dashboard’s-button:hover': {
    'background': u.primaryColorOpacity(0.1),
  },

  '.dashboard’s-button:active': {
    'background': u.primaryColorOpacity(0.2),
  },

  '.dashboard’s-button:focus': {
    'outline': 'none',
    'border-left-color': colors.cyan[700],
  },

  '.dashboard’s-category-title': {
    'line-height': u.inRem(60),
  },
};
