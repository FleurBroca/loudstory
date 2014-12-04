class RemoveCompanyidToTeams < ActiveRecord::Migration
  def change
    remove_reference :teams, :company, index: true
  end
end
