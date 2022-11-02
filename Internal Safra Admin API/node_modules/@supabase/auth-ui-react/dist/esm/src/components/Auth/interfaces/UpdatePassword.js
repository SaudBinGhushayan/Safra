import { __awaiter } from '../../../../_virtual/_tslib.js';
import { jsx, jsxs } from 'react/jsx-runtime';
import { useState } from 'react';
import '../../UI/Anchor.js';
import { Button } from '../../UI/Button.js';
import { Container } from '../../UI/Container.js';
import '../../UI/Divider.js';
import { Input } from '../../UI/Input.js';
import { Label } from '../../UI/Label.js';
import { Message } from '../../UI/Message.js';

function UpdatePassword(_ref) {
  let {
    supabaseClient,
    i18n,
    appearance
  } = _ref;

  var _a, _b, _c;

  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(false);

  const handlePasswordReset = e => __awaiter(this, void 0, void 0, function* () {
    e.preventDefault();
    setError('');
    setMessage('');
    setLoading(true);
    const {
      error
    } = yield supabaseClient.auth.updateUser({
      password
    });
    if (error) setError(error.message);else setMessage('Your password has been updated');
    setLoading(false);
  });

  return jsx("form", Object.assign({
    id: "auth-update-password",
    onSubmit: handlePasswordReset
  }, {
    children: jsxs(Container, Object.assign({
      gap: "large",
      direction: 'vertical',
      appearance: appearance
    }, {
      children: [jsxs(Container, Object.assign({
        gap: "large",
        direction: "vertical",
        appearance: appearance
      }, {
        children: [jsxs("div", {
          children: [jsx(Label, Object.assign({
            htmlFor: "password",
            appearance: appearance
          }, {
            children: (_a = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _a === void 0 ? void 0 : _a.password_label
          })), jsx(Input, {
            name: "password",
            placeholder: (_b = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _b === void 0 ? void 0 : _b.password_label,
            type: "password",
            onChange: e => setPassword(e.target.value),
            appearance: appearance
          })]
        }), jsx(Button, Object.assign({
          type: "submit",
          color: "primary",
          loading: loading,
          appearance: appearance
        }, {
          children: (_c = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _c === void 0 ? void 0 : _c.button_label
        }))]
      })), message && jsx(Message, Object.assign({
        appearance: appearance
      }, {
        children: message
      })), error && jsx(Message, Object.assign({
        color: "danger",
        appearance: appearance
      }, {
        children: error
      }))]
    }))
  }));
}

export { UpdatePassword };
