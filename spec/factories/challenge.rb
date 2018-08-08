FactoryBot.define do
  factory :challenge do
    user
    sequence(:min_rank) do
      range = (-30..-1).to_a.concat((1..9).to_a).sample
    end
    sequence(:max_rank) do
      range = []
      if min_rank > 0
        range = (min_rank..9).to_a
      else
        range = (min_rank..-1).to_a.concat((1..9).to_a)
      end
      range.sample
    end
  end
end
