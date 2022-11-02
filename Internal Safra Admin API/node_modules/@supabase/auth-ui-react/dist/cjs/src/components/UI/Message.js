'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var core = require('@stitches/core');
var utils = require('../../../common/theming/utils.js');

const messageDefaultStyles = core.css({
  fontFamily: '$bodyFontFamily',
  fontSize: '$baseBodySize',
  marginBottom: '$labelBottomMargin',
  display: 'block',
  textAlign: 'center',
  variants: {
    color: {
      default: {
        color: '$messageText'
      },
      danger: {
        color: '$messageTextDanger'
      }
    }
  }
});

const Message = _a => {
  var _b;

  var {
    children,
    appearance
  } = _a,
      props = _tslib.__rest(_a, ["children", "appearance"]);

  const classNames = utils.generateClassNames('message', messageDefaultStyles({
    color: props.color
  }), appearance);
  return jsxRuntime.jsx("span", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.message,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

exports.Message = Message;
