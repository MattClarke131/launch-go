class SampleBoard {
  static create(size) {
    let board = []
    for(let x=0; x<size; x++) {
      board.push([]);
      for(let y=0; y<size; y++) {
        board[x].push(this.randomStone())
      }
    }
    return board
  }

  static randomStone() {
    let options = ['white', 'black', 'empty']
    let randomIndex = Math.floor(Math.random() * options.length)
    let choice = options[randomIndex]

    return choice
  }
}

export default SampleBoard
