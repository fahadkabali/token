import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './index.scss';
import { AuthClient } from '@dfinity/auth-client';

// ReactDOM.createRoot(document.getElementById('root')).render(
//   <React.StrictMode>
//     <App />
//   </React.StrictMode>,
// );

const init = async () => {
  const authClient = await AuthClient.create();
  if(await authClient.isAuthenticated()){
    handleAuthenticated(authClient);
    return;
  }else{
    await authClient.login({
      identityProvider: 'https://identity.ic0.app/#authorize',
      onSuccess: () => {
        handleAuthenticated(authClient);
      }
    });
  };
};
async function handleAuthenticated(authClient){
  const root = ReactDOM.createRoot(document.getElementById('root'));
    root.render(<App />);
}
init();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals