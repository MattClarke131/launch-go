require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  let!(:game_1) { FactoryBot.create(:game) }
  let!(:move_1) { FactoryBot.create(:move, game: game_1, move_number: 1) }

  describe 'GET#show' do
    it 'should return the correct game' do
      get :show, params: {
        id: game_1.id,
        game: { id: game_1.id }
      }
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq('application/json')

      expect(returned_json['id']).to eq(game_1.id)
    end
  end
end
