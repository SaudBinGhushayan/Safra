import { __awaiter } from '../../../../_virtual/_tslib.js';
import { jsx, Fragment, jsxs } from 'react/jsx-runtime';
import { useState } from 'react';
import '../../UI/Anchor.js';
import { Button } from '../../UI/Button.js';
import { Container } from '../../UI/Container.js';
import { Divider } from '../../UI/Divider.js';
import '../../UI/Input.js';
import '../../UI/Label.js';
import '../../UI/Message.js';
import * as Icons from '../Icons.js';

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
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const verticalSocialLayout = socialLayout === 'vertical' ? true : false;

  const handleProviderSignIn = provider => __awaiter(this, void 0, void 0, function* () {
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

  return jsx(Fragment, {
    children: providers && providers.length > 0 && jsxs(Fragment, {
      children: [jsx(Container, Object.assign({
        gap: "large",
        direction: "vertical",
        appearance: appearance
      }, {
        children: jsx(Container, Object.assign({
          direction: verticalSocialLayout ? 'vertical' : 'horizontal',
          gap: verticalSocialLayout ? 'small' : 'medium',
          appearance: appearance
        }, {
          children: providers.map(provider => {
            var _a;

            const AuthIcon = Icons[provider];
            return jsx(Button, Object.assign({
              color: "default",
              icon: AuthIcon ? jsx(AuthIcon, {}) : '',
              loading: loading,
              onClick: () => handleProviderSignIn(provider),
              appearance: appearance
            }, {
              children: verticalSocialLayout && ((_a = i18n[view]) === null || _a === void 0 ? void 0 : _a.social_provider_text) + ' ' + capitalize(provider)
            }), provider);
          })
        }))
      })), !onlyThirdPartyProviders && jsx(Divider, {
        appearance: appearance
      })]
    })
  });
}

export { SocialAuth };
