import React from 'react';
import SelectTile from './SelectTile'

class NewChallengeForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      minRank: '',
      maxRank: '',
    }
    this.handleMinChange = this.handleMinChange.bind(this)
    this.handleMaxChange = this.handleMaxChange.bind(this)
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

  render() {
    return (
      <form className='new-challenge-form'>
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
