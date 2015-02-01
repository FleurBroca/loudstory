ActiveAdmin.register Lesson do

  index do
    selectable_column
    column :post do |lesson|
      link_to lesson.post, admin_lesson_path(lesson)
    end
    column :position
    column :title
    column :content
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :position
      f.input :post
      f.input :title
      f.input :content
    end
    f.actions
  end

  permit_params :title, :content, :position, :post_id



end
