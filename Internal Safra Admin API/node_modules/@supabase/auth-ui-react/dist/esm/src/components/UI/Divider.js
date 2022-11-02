import { __rest } from '../../../_virtual/_tslib.js';
import { jsx } from 'react/jsx-runtime';
import { css } from '@stitches/core';
import { generateClassNames } from '../../../common/theming/utils.js';

const dividerDefaultStyles = css({
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
      props = __rest(_a, ["children", "appearance"]);

  const classNames = generateClassNames('divider', dividerDefaultStyles(), appearance);
  return jsx("div", Object.assign({}, props, {
    style: (_b = appearance === null || appearance === void 0 ? void 0 : appearance.style) === null || _b === void 0 ? void 0 : _b.divider,
    className: classNames.join(' ')
  }));
};

export { Divider };
