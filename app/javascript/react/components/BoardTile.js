import React from 'react'

const BoardTile = (props) => {
  let classes = 'board-tile'
  if(props.top && props.left) {
    classes += ' board-tile-top-left'
  } else if (props.top && props.right) {
    classes += ' board-tile-top-right'
  } else if (props.bottom && props.left) {
    classes += ' board-tile-bottom-left'
  } else if (props.bottom && props.right) {
    classes += ' board-tile-bottom-right'
  } else if (props.top) {
    classes += ' board-tile-side-top'
  } else if (props.bottom) {
    classes += ' board-tile-side-bottom'
  } else if (props.left) {
    classes += ' board-tile-side-left'
  } else if (props.right) {
    classes += ' board-tile-side-right'
  } else {
    classes += ' board-tile-center'
  }

  let stoneColor = 'stone-' + props.color


  let makeMove = () => {
    props.makeMove(props.x, props.y)
  }


  return(
    <div className={classes} onClick={makeMove}>
      <div className='board-tile-up-left' />
      <div className='board-tile-up-right' />
      <div className='board-tile-down-left' />
      <div className='board-tile-down-right' />
      <div className={stoneColor} />
    </div>
  )
}

export default BoardTile
