import React from 'react'
import { Route, IndexRoute, Router, browserHistory } from 'react-router'

import ChallengesContainer from './containers/ChallengesContainer'

export const App = (props) => {
  return (
    <div>
      <Router history={browserHistory}>
        <Route path='/' >
          <Route path='/challenges'>
            <IndexRoute component={ChallengesContainer} />
          </Route>
        </Route>
      </Router>
    </div>
  )
}

export default App
