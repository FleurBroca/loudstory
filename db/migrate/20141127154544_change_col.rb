class ChangeCol < ActiveRecord::Migration
  def change
    change_column :answers, :content, :text
  end
end
