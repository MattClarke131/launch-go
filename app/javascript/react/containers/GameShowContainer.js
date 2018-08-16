import React from 'react'
import BoardContainer from './BoardContainer'
import GameInfoTile from '../components/GameInfoTile'

class GameShowContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      game: {
        id: props.params.id,
        board_states: [],
        player_turn: 'black',
        move_number: 1,
        size: 9,
        players: {
          black: '',
          white: ''
        },
      },
      gameCompleted: false
    }
    this.generateEmptyBoardState = this.generateEmptyBoardState.bind(this)
    this.makeMove = this.makeMove.bind(this)
    this.updateBoard = this.updateBoard.bind(this)
    this.listenForUpdate = this.listenForUpdate.bind(this)
  }

  listenForUpdate() {
    let delay = 250
    if(!this.state.gameCompleted) {
      this.updateBoard()
      window.setTimeout(() => {
        this.listenForUpdate()
      }, delay)
    }
  }

  generateEmptyBoardState() {
    let boardState = []
    for (let i=0; i<this.state.game.size; i++) {
      boardState.push([])
    }

    for(let y=this.state.game.size-1; y>=0; y--) {
      for(let x=0; x<this.state.game.size; x++) {
        boardState[x].push('empty')
      }
    }
    return boardState
  }

  makeMove(x_coord,y_coord) {
    let formPayload = {
      x: x_coord-1,
      y: this.state.game.board_states[0][0].length-y_coord
    }
    fetch(`/api/v1/games/${this.state.game.id}`, {
      credentials: 'same-origin',
      method: 'PATCH',
      body: JSON.stringify(formPayload),
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(response => {
      this.setState(response)
    })
  }

  componentDidMount() {
    this.updateBoard()
    this.listenForUpdate()
  }

  updateBoard() {
    fetch(`/api/v1/games/${this.state.game.id}`)
    .then(response => {
      if(response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
            error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      this.setState(response)
    })
  }

  render() {
    let boardState
    if (this.state.game.board_states.length !== 0) {
      boardState = this.state.game.board_states[0]
    } else {
      boardState = this.generateEmptyBoardState();
    }

    let player_turn =
      this.state.game.board_states.length % 2 === 0 ? 'white' : 'black'

    return(
      <div className='game-show-container'>
        <GameInfoTile
          player_black={this.state.game.players.black}
          player_white={this.state.game.players.white}
          player_turn={player_turn}
        />
        <BoardContainer
          size={this.state.game.size}
          boardState={boardState}
          legalMoves={this.state.game.legal_moves}
          makeMove={this.makeMove}
        />
      </div>
    )
  }
}

export default GameShowContainer
