class Division < ApplicationRecord
  belongs_to :league
  has_many :seasons, dependent: :destroy
end
