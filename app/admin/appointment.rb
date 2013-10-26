ActiveAdmin.register Appointment do
  form do |f|
    f.inputs "Patient Details" do
      f.input :patient
      f.input :medic
      f.input :start, :as => :just_datetime_picker
      f.input :end, :as => :just_datetime_picker
  	end
    f.actions
  end

  controller do
    def permitted_params
      params.permit appointment: [:patient_id, :medic_id, :start_date, :start_time_hour, :start_time_minute, :end_date, :end_time_hour, :end_time_minute]
    end
  end

end