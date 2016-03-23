exports.inRem = (pixels) => (
  `${pixels / 16}rem`
);

exports.primaryColorOpacity = (factor) => (
  `rgba(0, 0, 0, ${factor * 0.87})`
);
