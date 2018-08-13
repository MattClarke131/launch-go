import React from 'react';
import SelectTile from '../components/SelectTile'

class NewChallengeForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      minRank: '',
      maxRank: '',
    }
    this.handleMinChange = this.handleMinChange.bind(this)
    this.handleMaxChange = this.handleMaxChange.bind(this)
    this.handleFormSubmit = this.handleFormSubmit.bind(this)
  }

  handleMinChange(event) {
    this.setState({
      minRank: event.target.value
    })
  }
  handleMaxChange(event) {
    this.setState({
      maxRank: event.target.value
    })
  }

  handleFormSubmit(event) {
    event.preventDefault();
    let formPayload = {
      challenge: {
        minRank: this.state.minRank,
        maxRank: this.state.maxRank,
        userEmail: this.props.currentUser.email
      }
    }
    fetch('/api/v1/challenges.json', {
      credentials: 'same-origin',
      method: 'POST',
      body: JSON.stringify(formPayload),
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => {
      if(response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      if(response.errors.length === 0) {
        let newChallenge = {
          max_rank: response.challenge.max_rank,
          min_rank: response.challenge.min_rank,
          user: {
            email: response.challenge.user.email,
            rank: response.challenge.user.rank
          },
          current_user: {
            email: this.props.currentUser.email,
            rank: this.props.currentUser.rank
          }
        }
        this.props.addNewChallenge(newChallenge)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    return (
      <form className='new-challenge-form' onSubmit={this.handleFormSubmit}>
        <label>
          <h3>
            Create a new challenge:
          </h3>
          <br />
          <SelectTile
            value={this.state.minRank}
            label={'Min. Rank'}
            handleChange={this.handleMinChange}
          />
          <SelectTile
            value={this.state.maxRank}
            label={'Max. Rank'}
            handleChange={this.handleMaxChange}
          />
          <input className ='button challenge-submit' type='submit' value='submit' />
        </label>
      </form>
    )
  }
}

export default NewChallengeForm;
