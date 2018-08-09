import React from 'react'
import BoardContainer from './BoardContainer'

class GameShowContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      game: {
        id: props.game_id,
        player_black: '',
        player_white: '',
        board_state: [],
        player_turn: 'black',
        move_number: 1,
        size: 9
      }
    }
  }

  componentDidMount() {
    fetch(`/api/v1/games/1`)
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
    return(
      <div className='game-show-container'>
        <BoardContainer
          size={this.state.game.size}
          board_state={this.state.game.board_state}
        />
      </div>
    )
  }
}

export default GameShowContainer
