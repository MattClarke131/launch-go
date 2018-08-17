import { mount } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';
import fetchMock from 'fetch-mock';

import GameShowContainer from '../../../app/javascript/react/containers/GameShowContainer';
import SampleBoard from '../sampleBoard'


describe('GameShowContainer', () => {
  let wrapper;
  let response = {
    game: {
      id: 361,
      player_black: 'Lee Sedol',
      player_white: 'Gu Li',
      board_states: [JSON.stringify(SampleBoard.create(9))],
      player_turn: 'black',
      move_number: 55,
      size: 9,
      result: 'incomplete'
    }
  }

  beforeEach(() => {
    fetchMock.get(`/api/v1/games/${response.game.id}`, {
      status: 200,
      body: response
    });
    wrapper = mount(
      <GameShowContainer
        params={{id: response.game.id}}
      />
    )
  });

  afterEach(fetchMock.restore)

  describe('Visitor: Game Show Page', () => {
    it('renders', () => {
      expect(wrapper.exists()).toBe(true)
    })

    it('has an initial state', () => {
      expect(wrapper.state()).toEqual({
        game: {
          id: response.game.id,
          board_states: [],
          player_turn: 'black',
          move_number: 1,
          size: 9,
          players: {
            black: '',
            white: ''
          },
          result: 'incomplete'
        }
      })
    })

    it('updates state after a fetch request', (done) => {
      setTimeout(() => {
        expect(wrapper.state().game.id).toEqual(response.game.id)
        expect(wrapper.state().game.player_black).toEqual(response.game.player_black)
        expect(wrapper.state().game.player_white).toEqual(response.game.player_white)
        expect(wrapper.state().game.player_turn).toEqual(response.game.player_turn)
        expect(wrapper.state().game.move_number).toEqual(response.game.move_number)
        expect(wrapper.state().game.board_states[0]).toEqual(response.game.board_states[0])
        done()
      }, 0)
    })
  })
});
