import { mount } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';
import fetchMock from 'fetch-mock';

import ChallengesContainer from '../../../app/javascript/react/containers/ChallengesContainer';
import ChallengeTile from '../../../app/javascript/react/components/ChallengeTile';

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

  describe('Visitor: Challenges Page', () => {
    it('renders', () => {
      expect(wrapper.exists()).toBe(true)
    })

    it('has an initial state', () => {
      expect(wrapper.state()).toEqual({
        challenges: []
      })
    })

    it('updates state after a fetch request', (done) => {
      setTimeout(() => {
        expect(wrapper.state()).toEqual(challenges)
        done()
      })
    }, 0)

    describe('displays a challenge tile', () => {
      it('challenge tile exists', (done) => {
        setTimeout(() => {
          expect(wrapper.contains(<ChallengeTile />)).toEqual(true)
          done()
        })
      }, 0)

      it('challenge tile contains populated data', (done) => {
        setTimeout(() => {
          let challenge1MinRank = challenges['challenges'][0]['min_rank']
          let challenge1MaxRank = challenges['challenges'][0]['max_rank']
          let user1Email = challenges['challenges'][0]['user']['email']
          let user1Rank = challenges['challenges'][0]['user']['rank']
          expect(wrapper.text()).toContain(challenge1MinRank)
          expect(wrapper.text()).toContain(challenge1MaxRank)
          expect(wrapper.text()).toContain(user1Email)
          expect(wrapper.text()).toContain(user1Rank)
          // expect(wrapper.find(challenges['challenges'][0]['user']['email'])).toEqual(true)
          done()
        }, 0)
      })
    })
  })
})
