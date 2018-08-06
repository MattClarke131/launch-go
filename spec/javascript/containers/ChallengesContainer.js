import ChallengesContainer from '../../../app/javascript/react/containers/ChallengesContainer';
import { mount } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';
import fetchMock from 'fetch-mock';

describe('ChallengesContainer', () => {
  let wrapper;
  let challenges = {
    'challenges': [
      {
        max_rank: 1,
        min_rank: -4,
        user: {
          email: 'MC@gmail.com',
          rank: -2
        }
      },
      {
        max_rank: 7,
        min_rank: 3,
        user: {
          email: 'MrC@gmail.com',
          rank: 5
        }
      }
    ]
  }

  beforeEach(() => {
    fetchMock.get(`/api/v1/challenges.json`, {
      status: 200,
      body: challenges
    });
    wrapper = mount(
      <ChallengesContainer />
    );
  });

  afterEach(fetchMock.restore)

  describe('Visitor Challenges Index Page', () => {
    it('has an initial state', () => {
      expect(wrapper.state()).toEqual({
        challenges: []
      })
      expect(false).toEqual(false)
    })

    it('updates state after a fetch request', (done) => {
      setTimeout(() => {
        expect(wrapper.state()).toEqual({
          challenges
        })
      })
      done()
    }, 0)
  })
})
