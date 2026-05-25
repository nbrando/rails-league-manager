class User < ApplicationRecord
    has_secure_password

    has_many :players, dependent: :nullify
    has_many :user_roles, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true

    def super_admin?
        super_admin
    end

    def league_admin?(league)
        super_admin? || user_roles.exists?(roles: 'league_admin', resource_type: 'League', resource_id: league.id)
    end

    def team_admin?(team)
        super_admin? || user_roles.exists?('team_admin', resource_type: 'Team', resource_id: team.id) || league_admin?(team.league)
    end
end
