ActiveAdmin.register Lesson do

  index do
    selectable_column
    column :id
    column :position
    column :title
    column :content
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :position
      f.input :post_id
      f.input :title
      f.input :content
    end
    f.actions
  end

  permit_params :title, :content, :position



end
