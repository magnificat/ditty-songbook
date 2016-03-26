exports.inRem = (pixels) => (
  `${pixels / 16}rem`
);

exports.primaryColorOpacity = (factor) => (
  `rgba(0, 0, 0, ${factor * 0.87})`
);

exports.whiteOpacity = (factor) => (
  `rgba(255, 255, 255, ${factor})`
);
