module.exports = {
  '.display': {
    'position': 'absolute',
    'top': '0',
    'left': '25rem',

    'height': '100%',
    'width': '100%',

    'background': 'black',
  },

  '.display::before': {
    'display': 'block',
    'content': '" "',
    'position': 'absolute',
    'top': '-15rem',
    'left': '0',
    'bottom': '-15rem',
    'right': '0',

    'box-shadow': '0 0 10rem black',
  },
};
