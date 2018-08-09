FactoryBot.define do
  factory :board_state do
    game
    size 9

    sequence(:board) do
      new_board = Array.new(9) do
        Array.new(9) do
          %w(black white empty).sample
        end
      end

      JSON.generate(new_board)
    end

    sequence(:move_number) { |n| n }
  end
end
