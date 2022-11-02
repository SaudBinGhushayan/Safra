'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var _tslib = require('../../../../_virtual/_tslib.js');
var jsxRuntime = require('react/jsx-runtime');
var react = require('react');
require('../../UI/Anchor.js');
var Button = require('../../UI/Button.js');
var Container = require('../../UI/Container.js');
var Divider = require('../../UI/Divider.js');
require('../../UI/Input.js');
require('../../UI/Label.js');
require('../../UI/Message.js');
var Icons = require('../Icons.js');

function SocialAuth(_ref) {
  let {
    supabaseClient,
    socialLayout = 'vertical',
    providers,
    redirectTo,
    onlyThirdPartyProviders,
    view,
    i18n,
    appearance
  } = _ref;
  const [loading, setLoading] = react.useState(false);
  const [error, setError] = react.useState('');
  const verticalSocialLayout = socialLayout === 'vertical' ? true : false;

  const handleProviderSignIn = provider => _tslib.__awaiter(this, void 0, void 0, function* () {
    setLoading(true);
    const {
      error
    } = yield supabaseClient.auth.signInWithOAuth({
      provider,
      options: {
        redirectTo
      }
    });
    if (error) setError(error.message);
    setLoading(false);
  });

  function capitalize(word) {
    const lower = word.toLowerCase();
    return word.charAt(0).toUpperCase() + lower.slice(1);
  }

  return jsxRuntime.jsx(jsxRuntime.Fragment, {
    children: providers && providers.length > 0 && jsxRuntime.jsxs(jsxRuntime.Fragment, {
      children: [jsxRuntime.jsx(Container.Container, Object.assign({
        gap: "large",
        direction: "vertical",
        appearance: appearance
      }, {
        children: jsxRuntime.jsx(Container.Container, Object.assign({
          direction: verticalSocialLayout ? 'vertical' : 'horizontal',
          gap: verticalSocialLayout ? 'small' : 'medium',
          appearance: appearance
        }, {
          children: providers.map(provider => {
            var _a;

            const AuthIcon = Icons[provider];
            return jsxRuntime.jsx(Button.Button, Object.assign({
              color: "default",
              icon: AuthIcon ? jsxRuntime.jsx(AuthIcon, {}) : '',
              loading: loading,
              onClick: () => handleProviderSignIn(provider),
              appearance: appearance
            }, {
              children: verticalSocialLayout && ((_a = i18n[view]) === null || _a === void 0 ? void 0 : _a.social_provider_text) + ' ' + capitalize(provider)
            }), provider);
          })
        }))
      })), !onlyThirdPartyProviders && jsxRuntime.jsx(Divider.Divider, {
        appearance: appearance
      })]
    })
  });
}

exports.SocialAuth = SocialAuth;
