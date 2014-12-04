class RemoveUseridFromTeam < ActiveRecord::Migration
  def change
    remove_reference :teams, :user, index: true
  end
end
