require 'rails_helper'

RSpec.describe Api::V1::ChallengesController, type: :controller do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:challenge_1) { FactoryBot.create(:challenge, user: user_1) }
  let!(:challenge_2) { FactoryBot.create(:challenge, user: user_2) }

  describe 'GET#index' do
    it 'should return a list of challenges' do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq('application/json')

      expect(returned_json['challenges'].length).to eq 2
    end

    it 'should return the correct format' do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq('application/json')

      expect(
        returned_json['challenges'][0]['max_rank']
      ).to eq challenge_1.max_rank
      expect(
        returned_json['challenges'][0]['min_rank']
      ).to eq challenge_1.min_rank
      expect(
        returned_json['challenges'][0]['user']['email']
      ).to eq user_1.email
      expect(
        returned_json['challenges'][0]['user']['rank']
      ).to eq user_1.rank
    end
  end
end
