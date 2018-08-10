import React from 'react'

const BoardTile = (props) => {
  return(
    <div className='board-tile'>
      {props.color}
    </div>
  )
}

export default BoardTile
