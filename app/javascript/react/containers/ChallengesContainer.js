import React from 'react'

import ChallengeTile from '../components/ChallengeTile'

class ChallengesContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      challenges: []
    }
  }

  componentDidMount() {
    fetch('/api/v1/challenges.json')
    .then(response => {
      if(response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
            error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      this.setState(response)
    })
  }

  render() {
    let challenges = this.state.challenges.map(challenge => {
      return (
        <ChallengeTile
          key={this.state.challenges.indexOf(challenge)}
          userEmail={challenge.user.email}
          userRank={challenge.user.rank}
          minRank={challenge.min_rank}
          maxRank={challenge.max_rank}
        />
      )
    })

    return(
      <div>
        {challenges}
      </div>
    )
  }
}

export default ChallengesContainer
