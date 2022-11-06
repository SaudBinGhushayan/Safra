'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var react = require('react');
require('../../UI/Anchor.js');
var Button = require('../../UI/Button.js');
var Container = require('../../UI/Container.js');
require('../../UI/Divider.js');
var Input = require('../../UI/Input.js');
var Label = require('../../UI/Label.js');
var Message = require('../../UI/Message.js');

function UpdatePassword(_ref) {
  let {
    supabaseClient,
    i18n,
    appearance
  } = _ref;

  var _a, _b, _c;

  const [password, setPassword] = react.useState('');
  const [error, setError] = react.useState('');
  const [message, setMessage] = react.useState('');
  const [loading, setLoading] = react.useState(false);

  const handlePasswordReset = e => _tslib.__awaiter(this, void 0, void 0, function* () {
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

  return jsxRuntime.jsx("form", Object.assign({
    id: "auth-update-password",
    onSubmit: handlePasswordReset
  }, {
    children: jsxRuntime.jsxs(Container.Container, Object.assign({
      gap: "large",
      direction: 'vertical',
      appearance: appearance
    }, {
      children: [jsxRuntime.jsxs(Container.Container, Object.assign({
        gap: "large",
        direction: "vertical",
        appearance: appearance
      }, {
        children: [jsxRuntime.jsxs("div", {
          children: [jsxRuntime.jsx(Label.Label, Object.assign({
            htmlFor: "password",
            appearance: appearance
          }, {
            children: (_a = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _a === void 0 ? void 0 : _a.password_label
          })), jsxRuntime.jsx(Input.Input, {
            name: "password",
            placeholder: (_b = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _b === void 0 ? void 0 : _b.password_label,
            type: "password",
            onChange: e => setPassword(e.target.value),
            appearance: appearance
          })]
        }), jsxRuntime.jsx(Button.Button, Object.assign({
          type: "submit",
          color: "primary",
          loading: loading,
          appearance: appearance
        }, {
          children: (_c = i18n === null || i18n === void 0 ? void 0 : i18n.update_password) === null || _c === void 0 ? void 0 : _c.button_label
        }))]
      })), message && jsxRuntime.jsx(Message.Message, Object.assign({
        appearance: appearance
      }, {
        children: message
      })), error && jsxRuntime.jsx(Message.Message, Object.assign({
        color: "danger",
        appearance: appearance
      }, {
        children: error
      }))]
    }))
  }));
}

exports.UpdatePassword = UpdatePassword;
