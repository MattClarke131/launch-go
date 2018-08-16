import React from 'react'
import { Route, IndexRoute, Router, browserHistory } from 'react-router'

import ChallengesContainer from './containers/ChallengesContainer'
import GameShowContainer from './containers/GameShowContainer'

export const App = (props) => {
  return (
    <div>
      <Router history={browserHistory}>
        <Route path='/' >
          <IndexRoute component={ChallengesContainer} />
          <Route path='/challenges' component={ChallengesContainer} />
          <Route path= "/games/:id" component={GameShowContainer} />
        </Route>
      </Router>
    </div>
  )
}

export default App
