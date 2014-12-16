class Comment < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  validates_presence_of :content
end
