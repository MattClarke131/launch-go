import React from 'react'
import BoardContainer from './BoardContainer'
import GameInfoTile from '../components/GameInfoTile'

class GameShowContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      game: {
        id: props.params.id,
        player_black: '',
        player_white: '',
        board_states: [],
        player_turn: 'black',
        move_number: 1,
        size: 9
      }
    }
    this.generateEmptyBoardState = this.generateEmptyBoardState.bind(this)
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

  componentDidMount() {
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
    return(
      <div className='game-show-container'>
        <GameInfoTile

        />
        <BoardContainer
          size={this.state.game.size}
          boardState={boardState}
        />
      </div>
    )
  }
}

export default GameShowContainer
