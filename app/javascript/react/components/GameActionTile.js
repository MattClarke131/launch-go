import React from 'react';

const GameActionTile = (props) => {
  let pass = () => {
    props.makeMove({
      type: 'pass',
      x: null,
      y: null
    })
  }

  return(
    <div className = 'game-action-tile'>
      <button onClick={pass}>Pass</button>
      <button>Resign</button>
    </div>
  )
}

export default GameActionTile
