require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'validations' do
    let!(:user) { FactoryBot.build(:user)}
    let!(:challenge1) { FactoryBot.build(:challenge, user: user)}
    let!(:challenge2) { FactoryBot.build(:challenge, user: user, min_rank: -31)}
    let!(:challenge3) { FactoryBot.build(:challenge, user: user, min_rank: 0)}
    let!(:challenge4) { FactoryBot.build(:challenge, user: user, min_rank: 10)}
    let!(:challenge5) { FactoryBot.build(:challenge, user: user, max_rank: -31)}
    let!(:challenge6) { FactoryBot.build(:challenge, user: user, max_rank: 0)}
    let!(:challenge7) { FactoryBot.build(:challenge, user: user, max_rank: 10)}

    it 'is valid without min_rank or max_rank' do
      expect(challenge1).to be_valid
    end

    it 'is invalid with a min_rank lower than -30' do
      expect(challenge2).to_not be_valid
    end

    it 'is invalid with a min_rank equal to 0' do
      expect(challenge3).to_not be_valid
    end

    it 'is invalid with a min_rank higher than 9' do
      expect(challenge4).to_not be_valid
    end

    it 'is invalid with a max_rank lower than -30' do
      expect(challenge5).to_not be_valid
    end

    it 'is invalid with a max_rank equal to 0' do
      expect(challenge6).to_not be_valid
    end

    it 'is invalid with a max_rank higher than 9' do
      expect(challenge7).to_not be_valid
    end
  end
end
