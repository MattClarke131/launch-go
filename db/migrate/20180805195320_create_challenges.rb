class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.integer :min_rank, default: -30
      t.integer :max_rank, default: 9

      t.belongs_to :user
    end
  end
end
