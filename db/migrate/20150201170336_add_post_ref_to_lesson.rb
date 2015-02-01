class AddPostRefToLesson < ActiveRecord::Migration
  def change
    add_reference :lessons, :post, index: true
  end
end
