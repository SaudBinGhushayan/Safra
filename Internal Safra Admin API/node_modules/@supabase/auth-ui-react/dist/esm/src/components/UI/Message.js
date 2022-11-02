import { __rest } from '../../../_virtual/_tslib.js';
import { jsx } from 'react/jsx-runtime';
import { css } from '@stitches/core';
import { generateClassNames } from '../../../common/theming/utils.js';

const messageDefaultStyles = css({
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
      props = __rest(_a, ["children", "appearance"]);

  const classNames = generateClassNames('message', messageDefaultStyles({
    color: props.color
  }), appearance);
  return jsx("span", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.message,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

export { Message };
