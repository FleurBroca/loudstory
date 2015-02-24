class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :tool
      t.string :deadline
      t.string :language

      t.timestamps
    end
  end
end
