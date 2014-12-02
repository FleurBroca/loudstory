class Exercise < ActiveRecord::Base
  belongs_to :track
  has_many :questions
  has_many :sessions
  has_many :answers

  has_attached_file :photo,
    styles: { medium: "200x200#", thumb: "100x100>" }

  validates_attachment_content_type :photo,
    content_type: /\Aimage\/.*\z/

  validates_presence_of :title, :description, :track_id, :position
end
