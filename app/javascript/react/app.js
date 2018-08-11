import React from 'react'
import { Route, IndexRoute, Router, browserHistory } from 'react-router'

import ChallengesContainer from './containers/ChallengesContainer'
import GameShowContainer from './containers/GameShowContainer'

export const App = (props) => {
  return (
    <div>
      <Router history={browserHistory}>
        <Route path='/' >
          <Route path='/challenges'>
            <IndexRoute component={ChallengesContainer} />
          </Route>
          <Route path='/games'>
            <Route path= "/games/:id" component={GameShowContainer} />
          </Route>
        </Route>
      </Router>
    </div>
  )
}

export default App
