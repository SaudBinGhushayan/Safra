'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var core = require('@stitches/core');
var utils = require('../../../common/theming/utils.js');

const buttonDefaultStyles = core.css({
  fontFamily: '$buttonFontFamily',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  gap: '8px',
  borderRadius: '$borderRadiusButton',
  fontSize: '$baseButtonSize',
  padding: '$buttonPadding',
  cursor: 'pointer',
  borderWidth: '$buttonBorderWidth',
  borderStyle: 'solid',
  width: '100%',
  transitionPproperty: 'background-color',
  transitionTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)',
  transitionDuration: '100ms',
  variants: {
    color: {
      default: {
        backgroundColor: '$defaultButtonBackground',
        color: '$defaultButtonText',
        borderColor: '$defaultButtonBorder',
        '&:hover': {
          backgroundColor: '$defaultButtonBackgroundHover'
        }
      },
      primary: {
        backgroundColor: '$brand',
        color: '$brandButtonText',
        borderColor: '$brandAccent',
        '&:hover': {
          backgroundColor: '$brandAccent'
        }
      }
    }
  }
});

const Button = _a => {
  var _b;

  var {
    children,
    color = 'default',
    appearance,
    icon,
    loading = false
  } = _a,
      props = _tslib.__rest(_a, ["children", "color", "appearance", "icon", "loading"]);

  const classNames = utils.generateClassNames('button', buttonDefaultStyles({
    color: color
  }), appearance);
  return jsxRuntime.jsxs("button", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.button,
    className: classNames.join(' '),
    disabled: loading
  }, {
    children: [icon, children]
  }));
};

exports.Button = Button;
