import { __rest } from '../../../_virtual/_tslib.js';
import { jsx } from 'react/jsx-runtime';
import { css } from '@stitches/core';
import { generateClassNames } from '../../../common/theming/utils.js';

const labelDefaultStyles = css({
  fontFamily: '$labelFontFamily',
  fontSize: '$baseLabelSize',
  marginBottom: '$labelBottomMargin',
  color: '$inputLabelText',
  display: 'block'
});

const Label = _a => {
  var _b;

  var {
    children,
    appearance
  } = _a,
      props = __rest(_a, ["children", "appearance"]);

  const classNames = generateClassNames('label', labelDefaultStyles(), appearance);
  return jsx("label", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.label,
    className: classNames.join(' ')
  }, {
    children: children
  }));
};

export { Label };
