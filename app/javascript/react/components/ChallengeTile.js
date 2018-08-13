import React from 'react'
import ChallengeButton from './ChallengeButton'

const ChallengeTile = (props) => {
  let challengeUser = props.userEmail
  let currentUser
  if(props.currentUser !== null) {
    currentUser = props.currentUser.email
  }
  let challengeButton =
    <ChallengeButton
      currentUser={currentUser}
      challengeUser={challengeUser}
      handleChallengeClick={props.handleChallengeClick}
    />

  return(
    <div className='challenge-tile'>
      <div className='playerEmail field'>
        <div className='challenge-tile-title'>
          User
        </div>
        <div className='challenge-tile-value'>
          {props.userEmail}
        </div>
      </div>
      <div className='playerRank field'>
        <div className='challenge-tile-title'>
          Rank
        </div>
        <div className='challenge-tile-value'>
          {props.userRank}
        </div>
      </div>
      <div className='minRank field'>
        <div className='challenge-tile-title'>
          Min. Rank
        </div>
        <div className='challenge-tile-value'>
          {props.minRank}
        </div>
      </div>
      <div className='maxRank field'>
        <div className='challenge-tile-title'>
          Max. Rank
        </div>
        <div className='challenge-tile-value'>
          {props.maxRank}
        </div>
      </div>

      {challengeButton}

    </div>
  )
}

export default ChallengeTile
