ActiveAdmin.register Patient do
  index do
    column "Record ID", :record_id
    column :name
    column :prename
    column :title
    column :tel_number
    default_actions
  end

  form do |f|
    f.inputs "Patient Details" do
      f.input :record_id, label: "Record ID"
      f.input :name
      f.input :prename
      f.input :title
      f.input :tel_number
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit patient: [:record_id, :name, :prename, :title, :tel_number]
    end
  end
end