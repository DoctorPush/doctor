ActiveAdmin.register AdminUser do
  index do
    column :name
    column :prename
    column :title
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :prename
      f.input :title
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit admin_user: [:name, :prename, :title, :email, :password, :password_confirmation, :username]
    end
  end
end
