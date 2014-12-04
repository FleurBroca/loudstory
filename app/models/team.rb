class Team < ActiveRecord::Base
  has_many :users, through: :user_teams

  validates :name, uniqueness: true, :case_sensitive => false, :allow_blank => true

end
