import { __rest } from '../../../_virtual/_tslib.js';
import { jsx } from 'react/jsx-runtime';
import { css } from '@stitches/core';
import { generateClassNames } from '../../../common/theming/utils.js';

const anchorHTMLAttributes = css({
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
      props = __rest(_a, ["children", "appearance"]);

  const classNames = generateClassNames('anchor', anchorHTMLAttributes(), appearance);
  return jsx("a", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.anchor,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

export { Anchor };
