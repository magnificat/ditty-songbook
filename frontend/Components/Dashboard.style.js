const u = require('../styles/utils');
const c = require('../styles/config');
const colors = require('material-colors');

const dashboardPadding = 20;
const halfCategorySpacing = 10;
const categoryBorderWidth = 5;
const transitionDuration = '150ms';
const transitionFunction = 'cubic-bezier(0, 0, 0, 1)';

module.exports = {
  '.dashboard': {
    'padding': u.inRem(dashboardPadding),
    'width': u.inRem(c.navBarWidth),
    'height': '100%',
    'overflow': 'auto',
  },

  '.dashboard::-webkit-scrollbar': {
    'display': 'none',
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
    'font-size': u.inRem(14),
    'text-transform': 'uppercase',
    'letter-spacing': '0.07em',
  },

  '.dashboard’s-song': {
    'display': 'block',
    'overflow': 'hidden',
    'color': u.primaryColorOpacity(1),
    'transition': [
      `line-height ${transitionDuration} ${transitionFunction}`,
      `color ${transitionDuration} ${transitionFunction}`,
      `visibility ${transitionDuration} step-start`,
    ].join(', '),
  },

  [
    '.dashboard’s-category:not(.dashboard’s-category·unfolded)' +
    ' .dashboard’s-song'
  ]: {
    'line-height': '0rem',
    'visibility': 'hidden',
    'color': u.primaryColorOpacity(0),
    'transition-timing-function': [
      transitionFunction,
      transitionFunction,
      'step-end',
    ].join(', '),
  },
};
