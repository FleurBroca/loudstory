class AddDetailsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :url, :string
  end
end
