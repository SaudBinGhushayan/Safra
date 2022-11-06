'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var core = require('@stitches/core');
var utils = require('../../../common/theming/utils.js');

const anchorHTMLAttributes = core.css({
  fontFamily: '$bodyFontFamily',
  fontSize: '$baseBodySize',
  marginBottom: '$anchorBottomMargin',
  color: '$anchorTextColor',
  display: 'block',
  textAlign: 'center',
  textDecoration: 'underline',
  '&:hover': {
    color: '$anchorTextHoverColor'
  }
});

const Anchor = _a => {
  var _b;

  var {
    children,
    appearance
  } = _a,
      props = _tslib.__rest(_a, ["children", "appearance"]);

  const classNames = utils.generateClassNames('anchor', anchorHTMLAttributes(), appearance);
  return jsxRuntime.jsx("a", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.anchor,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

exports.Anchor = Anchor;
