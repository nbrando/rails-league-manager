class Round < ApplicationRecord
  belongs_to :season
  has_many :matches, dependent: :destroy
end
