import React from 'react';

const GameInfoTile = (props) => {
  let gameInfo

  if (props.gameResult == 'incomplete') {
    gameInfo = `TURN: ${props.player_turn}`
  } else {
    gameInfo = `RESULT: ${props.gameResult}`
  }

  return(
    <div className='game-info-tile'>
        BLACK: {props.player_black.email}
        <br/>
        WHITE: {props.player_white.email}
        <br />
        {gameInfo}
    </div>
  )
}

export default GameInfoTile;
