class DropCompanyTable < ActiveRecord::Migration
  def change
    drop_table :companies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
