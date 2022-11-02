import { __awaiter } from '../../../_virtual/_tslib.js';
import { jsx } from 'react/jsx-runtime';
import { useState, useEffect, useContext, createContext } from 'react';

const UserContext = /*#__PURE__*/createContext({
  user: null,
  session: null
});
const UserContextProvider = props => {
  var _a;

  const {
    supabaseClient
  } = props;
  const [session, setSession] = useState(null);
  const [user, setUser] = useState((_a = session === null || session === void 0 ? void 0 : session.user) !== null && _a !== void 0 ? _a : null);
  useEffect(() => {

    (() => __awaiter(void 0, void 0, void 0, function* () {
      var _a, _b;

      const {
        data
      } = yield supabaseClient.auth.getSession();
      setSession(data.session);
      setUser((_b = (_a = data.session) === null || _a === void 0 ? void 0 : _a.user) !== null && _b !== void 0 ? _b : null);
    }))();

    const {
      data: authListener
    } = supabaseClient.auth.onAuthStateChange((event, session) => __awaiter(void 0, void 0, void 0, function* () {
      var _c;

      setSession(session);
      setUser((_c = session === null || session === void 0 ? void 0 : session.user) !== null && _c !== void 0 ? _c : null);
    }));
    return () => {
      authListener === null || authListener === void 0 ? void 0 : authListener.subscription.unsubscribe();
    }; // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  const value = {
    session,
    user
  };
  return jsx(UserContext.Provider, Object.assign({
    value: value
  }, props));
};
const useUser = () => {
  const context = useContext(UserContext);

  if (context === undefined) {
    throw new Error(`useUser must be used within a UserContextProvider.`);
  }

  return context;
};

export { UserContextProvider, useUser };
