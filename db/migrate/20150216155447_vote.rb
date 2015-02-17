class Vote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :count_landing , default: 0
      t.integer :count_press , default: 0
      t.integer :count_pitch , default: 0

      t.timestamps
    end
  end
end
