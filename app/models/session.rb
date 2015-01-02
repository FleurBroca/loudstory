class Session < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
  belongs_to :team

  has_many :answers
  has_one :track, through: :exercise
  accepts_nested_attributes_for :answers

  validates_presence_of :user_id, :exercise_id, :team_id

  scope :team, -> { where(team: current_team) }
  scope :orderByQuestion, -> { order('position asc') }



end
