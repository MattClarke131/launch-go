import React from 'react';

const GameInfoTile = (props) => {
  return(
    <div className='game-info-tile'>
      <div className='player_black'>
        {props.player_black.email}
      </div>
      <div className='player_white'>
        {props.player_white.email}
      </div>
    </div>
  )
}

export default GameInfoTile;
