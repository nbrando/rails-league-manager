class Sport < ApplicationRecord
    has_many :leagues, dependent: :destroy
    validates :name, presence: true
end
