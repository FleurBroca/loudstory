ActiveAdmin.register Answer do


  index do
   selectable_column
   column :content do |answer|
      link_to answer.content, admin_answer_path(answer)
   end
   column :original_question do |answer|
      link_to answer.original_question, admin_answer_path(answer)
   end
   column :photo do |answer| image_tag answer.photo.url, width:"100px", height:"100px" end
   column :session_id
   column :user_id
   actions
 end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Identity" do
      f.input :content
      f.input :original_question
    end
    f.inputs "Photo" do
      f.input :photo
    end
    f.actions
  end

 show do |answer|
   attributes_table do
     row :question_id
     row :content
     row :photo do
       image_tag(answer.photo.url)
     end
     # Will display the image on show object page
  end
 end

  permit_params :content, :photo, :question_id, :original_question



end
