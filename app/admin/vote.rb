ActiveAdmin.register Vote do

  index do
    selectable_column
    column :count_landing
    column :count_press
    column :count_pitch
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :count_landing
      f.input :count_press
      f.input :count_pitch
    end
    f.actions
  end

  permit_params :count_pitch, :count_press, :count_landing

end
