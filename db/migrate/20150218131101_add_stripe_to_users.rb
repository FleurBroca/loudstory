class AddStripeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member, :boolean
    add_column :users, :pro, :boolean
  end
end
