ActiveAdmin.register Medic do
  index do
    column :name
    column :prename
    column :title
    default_actions
  end

  form do |f|
    f.inputs "Medic Details" do
      f.input :name
      f.input :prename
      f.input :title
      f.input :address
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit medic: [:name, :prename, :title, :address]
    end
  end
end