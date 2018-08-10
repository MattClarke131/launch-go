import React from 'react'
import BoardTile from '../components/BoardTile'

class BoardContainer extends React.Component {
  constructor(props) {
    super(props);
    this.createGameBoard = this.createGameBoard.bind(this)
  }

  createGameBoard() {
    let board = this.props.boardState.map((row, y) => {
      let populatedRow = row.map((item, x) => {
        return (
          <BoardTile
            key={`x:${x+1},y:${y+1}`}
            x={x+1}
            y={y+1}
            color={item}
          />
        )
      })

      return (
        <div key={`row: ${y}`} className='gameRow'>
          {populatedRow}
        </div>
      )
    })

    return board
  }

  render() {
    let gameBoard = this.createGameBoard()
    return (
      <div className='board-container'>
        {gameBoard}
      </div>
    )
  }
}

export default BoardContainer
