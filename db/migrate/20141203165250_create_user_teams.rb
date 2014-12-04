class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :user_teams do |t|
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
