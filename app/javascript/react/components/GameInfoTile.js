import React from 'react';

const GameInfoTile = (props) => {
  return(
    <div className='game-info-tile'>
        BLACK: {props.player_black.email}
        <br/>
        WHITE: {props.player_white.email}
        <br />
        TURN: {props.player_turn}
    </div>
  )
}

export default GameInfoTile;
