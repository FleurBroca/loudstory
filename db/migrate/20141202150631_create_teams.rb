class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :user, index: true
      t.references :company, index: true

      t.timestamps
    end
  end
end
