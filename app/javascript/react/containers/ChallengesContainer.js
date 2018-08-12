import React from 'react'
import ChallengeTile from '../components/ChallengeTile'
import NewChallengeForm from '../components/NewChallengeForm'

class ChallengesContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      challenges: []
    }
    this.formatRank = this.formatRank.bind(this)
  }

  formatRank(rank) {
    if(rank < 0) {
      return `${Math.abs(rank)}K`
    } else {
      return `${Math.abs(rank)}D`
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
          userRank={this.formatRank(challenge.user.rank)}
          minRank={this.formatRank(challenge.min_rank)}
          maxRank={this.formatRank(challenge.max_rank)}
        />
      )
    })

    return(
      <div className='challenges-container'>
        <NewChallengeForm />
        <h1>Open Challenges</h1>
        <div className='challenges-box'>
          {challenges}
        </div>
      </div>
    )
  }
}

export default ChallengesContainer
