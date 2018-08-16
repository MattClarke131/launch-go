import React from 'react'
import BoardTile from '../components/BoardTile'

class BoardContainer extends React.Component {
  constructor(props) {
    super(props);
    this.createGameBoard = this.createGameBoard.bind(this)
  }

  createGameBoard() {

    let board = this.props.boardState.map((row, x) => {
      let populatedRow = row.map((item, y) => {
        let bottom = y+1 === this.props.boardState.length
        let top = y+1 === 1
        let left = x+1 === 1
        let right = x+1 === this.props.boardState.length
        return (
          <BoardTile
            key={`x:${x+1},y:${this.props.boardState.length-y}`}
            x={x+1}
            y={this.props.boardState.length-y}
            color={item}
            top={top}
            bottom={bottom}
            left={left}
            right={right}
            makeMove={this.props.makeMove}
          />
        )
      })

      return (
        <div key={`row: ${x}`} className='game-row'>
          {populatedRow}
        </div>
      )
    })

    return (
      <div className='game-board'>
        {board}
      </div>
    )
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
