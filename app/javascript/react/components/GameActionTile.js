import React from 'react';

const GameActionTile = (props) => {
  let pass = () => {
    props.makeMove({
      type: 'pass',
      x: null,
      y: null
    })
  }

  let resign = () => {
    props.makeMove({
      type: 'resign'
    })
  }

  return(
    <div className = 'game-action-tile'>
      <button onClick={pass}>Pass</button>
      <button onClick={resign}>Resign</button>
    </div>
  )
}

export default GameActionTile
