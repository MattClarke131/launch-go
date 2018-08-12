import React from 'react';

const SelectTile = (props) => {
  let options = [
    <option key={'emptyField'} />
  ]
  for(let i = -30; i <= 9; i++) {
    if(i < 0) {
      options.push(
        <option key={i} value={i}>{`${i}k`}</option>
      )
    } else if (i > 0) {
      options.push(
        <option key={i} value={i}>{`${i}d`}</option>
      )
    }
  }

  return(
    <label>
      {props.label}
      <select value={props.value} onChange={props.handleChange}>
        {options}
      </select>
    </label>
  )
}

export default SelectTile;
