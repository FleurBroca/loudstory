class AddTeamRefToSessions < ActiveRecord::Migration
  def change
    add_reference :sessions, :team, index: true
  end
end
