class League < ApplicationRecord
  belongs_to :sport
  has_many :divisions, dependent: :destroy
  has_many :user_roles, as: :resource, dependent: :destroy

  validates :name, presence: true
end
