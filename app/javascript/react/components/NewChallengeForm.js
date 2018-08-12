import React from 'react';
import SelectTile from './SelectTile'

class NewChallengeForm extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <form className='new-challenge-form'>
        <SelectTile />
      </form>
    )
  }
}

export default NewChallengeForm;
