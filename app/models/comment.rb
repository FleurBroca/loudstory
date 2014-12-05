class Comment < ActiveRecord::Base
  belongs_to :answer

  validates_presence_of :answer_id
end
