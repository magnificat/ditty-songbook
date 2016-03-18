const merge = require('object-merge');

module.exports = merge(
  require('./styles/fonts.style'),
  require('./styles/reset.style'),
  require('./Components/Songbook.style'),
  require('./Components/Dashboard.style'),
  require('./Components/Display.style')
);
