import React from 'react'

const ChallengeButton = (props) => {
  let buttonClass;
  let buttonText;

  if(props.currentUser === undefined) {
    buttonClass = 'visitor-button';
    buttonText = 'SIGN IN!'
  } else if (props.currentUser === props.challengeUser) {
    buttonClass = 'delete-button';
    buttonText = 'DELETE'
  } else {
    buttonClass = 'accept-button';
    buttonText = 'ACCEPT'
  }

  return(
    <div>
      <button
        onClick={props.handleChallengeClick}
        className={buttonClass}
        value={props.challengeUser}
      >
        {buttonText}
      </button>
    </div>
  )
}

export default ChallengeButton
