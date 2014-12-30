ActiveAdmin.register Session do

index do
   selectable_column
   column :track_id do |session|
      link_to session.track, admin_session_path(session)
    end
   column :user_id do |session|
      link_to session.user_id, admin_session_path(session)
    end

 end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Identity" do
      f.input :user_id
      f.input :track_id
      f.input :description
    end
    f.inputs "Photo" do
      f.input :photo
    end
    f.actions
  end

 show do |track|
   attributes_table do
     row :track_id
     row :user_id
     row :original_question
     # Will display the image on show object page
    end
  end


  permit_params :track_id, :user_id # etc...



end
