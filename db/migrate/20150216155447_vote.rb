class Vote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :count_landing
      t.integer :count_press
      t.integer :count_pitch

      t.timestamps
    end
  end
end
