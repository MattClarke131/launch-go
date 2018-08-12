import React from 'react'
import ChallengeTile from '../components/ChallengeTile'
import NewChallengeForm from './NewChallengeForm'

class ChallengesContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      challenges: []
    }
    this.formatRank = this.formatRank.bind(this)
    this.userHasAChallenge = this.userHasAChallenge.bind(this)
    this.addNewChallenge = this.addNewChallenge.bind(this)
  }

  formatRank(rank) {
    if(rank < 0) {
      return `${Math.abs(rank)}K`
    } else {
      return `${Math.abs(rank)}D`
    }
  }

  userHasAChallenge() {
    let challenge_exists = false
    this.state.challenges.forEach((challenge) => {
      if(challenge.current_user == challenge.user.email) {
        challenge_exists = true
      }
    })

    return challenge_exists
  }

  addNewChallenge(newChallenge) {
    let challenges = this.state.challenges
    challenges.push(newChallenge)
    this.setState(challenges)
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

    let challengeForm = <NewChallengeForm />
    if (
      this.state.challenges.length === 0 ||
      this.state.challenges[0].current_user === null ||
      this.userHasAChallenge()
      ) {
      challengeForm = null
    }

    return(
      <div className='challenges-container'>
        {challengeForm}
        <h1>Open Challenges</h1>
        <div className='challenges-box'>
          {challenges}
        </div>
      </div>
    )
  }
}

export default ChallengesContainer
