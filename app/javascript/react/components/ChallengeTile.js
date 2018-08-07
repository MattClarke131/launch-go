import React from 'react'

const ChallengeTile = (props) => {
  return(
    <div className='challenge-tile'>
      <div className='playerEmail'>{props.userEmail}</div>
      <div className='playerRank'>{props.userRank}</div>
      <div className='minRank'>{props.minRank}</div>
      <div className='maxRank'>{props.maxRank}</div>
    </div>
  )
}

export default ChallengeTile
