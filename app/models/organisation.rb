class Organisation < ApplicationRecord
    has_many :teams
    validates :org_name, presence: true
end
