import React from 'react'
import ChallengeTile from '../components/ChallengeTile'
import NewChallengeForm from './NewChallengeForm'
import { browserHistory } from 'react-router'

class ChallengesContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      challenges: [],
      challenge_accepted: false
    }
    this.formatRank = this.formatRank.bind(this)
    this.userHasAChallenge = this.userHasAChallenge.bind(this)
    this.addNewChallenge = this.addNewChallenge.bind(this)
    this.handleChallengeClick = this.handleChallengeClick.bind(this)
    this.deleteChallenge = this.deleteChallenge.bind(this)
    this.acceptChallenge = this.acceptChallenge.bind(this)
    this.challengeListener = this.challengeListener.bind(this)
    this.checkStatus = this.checkStatus.bind(this)
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
      if(challenge.current_user.email == challenge.user.email) {
        challenge_exists = true
      }
    })

    return challenge_exists
  }

  addNewChallenge(newChallenge) {
    let challenges = this.state.challenges
    challenges.unshift(newChallenge)
    this.setState(challenges)
    this.challengeListener(newChallenge.id)
  }

  handleChallengeClick(event) {
    event.preventDefault()
    if(event.target.value === this.state.challenges[0].current_user.email) {
      this.deleteChallenge(event.target.value)
    } else if (this.state.challenges[0].current_user === undefined) {
      // Do nothing
    } else {
      this.acceptChallenge(event.target.value)
    }
  }

  deleteChallenge(user_email) {
    // the value of params does not matter, but there must be a value. I chose 1
    fetch(`/api/v1/challenges/1`, {
      credentials: 'same-origin',
      method: 'DELETE',
      body: JSON.stringify({user_email: user_email}),
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if(response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      if (response.deleted) {
        let newState = this.state
        newState.challenges.shift()
        this.setState(newState)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  acceptChallenge(user_email) {
    fetch(`/api/v1/games`, {
      credentials: 'same-origin',
      method: 'POST',
      body: JSON.stringify({user_email: user_email}),
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if(response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.status})`
        let error = new Error(errorMessage)
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      browserHistory.push(`/games/${response.game.id}`)
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  challengeListener(challengeId) {
    let delay = 500;
    if(!this.state.challenge_accepted) {
      this.checkStatus(challengeId)
      window.setTimeout(() => {
        this.challengeListener(challengeId)
      }, delay)
    }
  }

  checkStatus(challengeId) {
    fetch(`/api/v1/challenges/${challengeId}`)
    .then(response => {
      if(response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      if(response.gameId !== null) {
        this.state.challenge_accepted = true;
        browserHistory.push(`/games/${response.gameId}`)
      }
    })
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
    let currentUser = null
    if(this.state.challenges.length > 0) {
      currentUser = this.state.challenges[0].current_user
    }

    let challenges = this.state.challenges.map(challenge => {
      return (
        <ChallengeTile
          key={this.state.challenges.indexOf(challenge)}
          userEmail={challenge.user.email}
          userRank={this.formatRank(challenge.user.rank)}
          minRank={this.formatRank(challenge.min_rank)}
          maxRank={this.formatRank(challenge.max_rank)}
          currentUser={currentUser}
          handleChallengeClick={this.handleChallengeClick}
        />
      )
    })

    let challengeForm = null
    if (
      this.state.challenges.length !== 0 &&
      this.state.challenges[0].current_user !== null &&
      !this.userHasAChallenge()
      ) {
        challengeForm =
        <NewChallengeForm
          addNewChallenge={this.addNewChallenge}
          currentUser={this.state.challenges[0].current_user}
        />
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
