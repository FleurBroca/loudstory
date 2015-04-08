ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :admin
    actions
  end

    form do |f|
    f.inputs "Identity" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :stripe_customer_id
      f.input :member
      f.input :pro
    end
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
  end

  permit_params :first_name, :last_name, :email, :admin

end
