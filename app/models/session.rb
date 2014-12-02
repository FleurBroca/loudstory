class Session < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user

  has_many :answers
  has_one :track, through: :exercise
  accepts_nested_attributes_for :answers

  validates_presence_of :user_id, :exercise_id

end
