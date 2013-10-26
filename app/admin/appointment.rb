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

    alias_method :update_appointment, :update
    def update

        @old_appointment = Appointment.find(params["id"]) #Horrable hack because _changed? dosn't work

        update_appointment

        activity_parameters = {}
        activity_parameters.merge!({start: @appointment.start, start_was: @old_appointment.start}) if @appointment.start != @old_appointment.start
        activity_parameters.merge!({:'end' => @appointment.end, end_was: @old_appointment.end}) if @appointment.end != @old_appointment.end

        @appointment.create_activity :update, :owner => current_admin_user, :parameters => activity_parameters
    end
  end

end