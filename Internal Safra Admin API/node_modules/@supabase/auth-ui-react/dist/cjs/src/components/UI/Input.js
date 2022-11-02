'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var core = require('@stitches/core');
var utils = require('../../../common/theming/utils.js');

const inputDefaultStyles = core.css({
  fontFamily: '$inputFontFamily',
  background: '$inputBackground',
  borderRadius: '$inputBorderRadius',
  padding: '$inputPadding',
  cursor: 'text',
  borderWidth: '$inputBorderWidth',
  borderColor: '$inputBorder',
  borderStyle: 'solid',
  fontSize: '$baseInputSize',
  width: '100%',
  color: '$inputText',
  boxSizing: 'border-box',
  '&:hover': {
    borderColor: '$inputBorderHover',
    outline: 'none'
  },
  '&:focus': {
    borderColor: '$inputBorderFocus',
    outline: 'none'
  },
  '&::placeholder': {
    color: '$inputPlaceholder',
    letterSpacing: 'initial'
  },
  transitionPproperty: 'background-color, border',
  transitionTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)',
  transitionDuration: '100ms',
  variants: {
    type: {
      default: {
        letterSpacing: '0px'
      },
      password: {
        letterSpacing: '6px'
      }
    }
  }
});

const Input = _a => {
  var _b;

  var {
    children,
    appearance
  } = _a,
      props = _tslib.__rest(_a, ["children", "appearance"]);

  const classNames = utils.generateClassNames('input', inputDefaultStyles({
    type: props.type === 'password' ? 'password' : 'default'
  }), appearance);
  return jsxRuntime.jsx("input", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.input,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

exports.Input = Input;
