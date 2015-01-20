ActiveAdmin.register Post do

  index do
    selectable_column
    column :id
    column :position
    column :category
    column :title
    column :content
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :position
      f.input :category
      f.input :title
      f.input :content
    end
    f.actions
  end

  permit_params :category, :title, :content, :position


end
