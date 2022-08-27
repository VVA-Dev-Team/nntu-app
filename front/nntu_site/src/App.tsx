import React from 'react';
import './App.css';
import System from './components/view/System/System';
import SystemContainer from './components/view/System/System.container';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useRoutes } from 'react-router';
import MainRouter from './router/MainRouter';

function App() {

  const routes = useRoutes(MainRouter)

  return (
    <div className="App">
      {routes}
    </div>
  );
}

export default App;
