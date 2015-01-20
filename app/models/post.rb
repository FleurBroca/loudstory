class Post < ActiveRecord::Base

  has_many :lessons, -> { order("position ASC") }

  validates_presence_of :title, :content, :category, :position
end
