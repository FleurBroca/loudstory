class Team < ActiveRecord::Base
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :sessions

  validates :name, uniqueness: true, :case_sensitive => false, :allow_blank => true

end
