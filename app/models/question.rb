class Question < ActiveRecord::Base
  belongs_to :exercise
  has_many :answers
  scope :ordered, -> { order('position asc') }

  has_attached_file :photo,
    styles: { medium: "200x200#", thumb: "100x100>" }

  validates_attachment_content_type :photo,
    content_type: /\Aimage\/.*\z/


  validates_presence_of :title, :exercise_id, :position
end
