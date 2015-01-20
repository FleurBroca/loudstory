class Lesson < ActiveRecord::Base
  belongs_to :post
  acts_as_list scope: :post
  validates_presence_of :title, :content, :post_id, :position
end
