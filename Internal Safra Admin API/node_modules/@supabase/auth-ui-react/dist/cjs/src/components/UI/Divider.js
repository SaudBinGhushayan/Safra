'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var core = require('@stitches/core');
var utils = require('../../../common/theming/utils.js');

const dividerDefaultStyles = core.css({
  background: '$dividerBackground',
  display: 'block',
  margin: '16px 0',
  height: '1px',
  width: '100%'
});

const Divider = _a => {
  var _b;

  var {
    children,
    appearance
  } = _a,
      props = _tslib.__rest(_a, ["children", "appearance"]);

  const classNames = utils.generateClassNames('divider', dividerDefaultStyles(), appearance);
  return jsxRuntime.jsx("div", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.divider,
    className: classNames.join(' ')
  }));
};

exports.Divider = Divider;
