ActiveAdmin.register Appointment do
  form do |f|
    f.inputs "Patient Details" do
      f.input :title
      f.input :patient
      f.input :medic
      f.input :start, :as => :just_datetime_picker
      f.input :end, :as => :just_datetime_picker
  	end
    f.actions
  end

  member_action :push, :method => :get do
    @appointment = Appointment.find(params[:id])

    options = { :body => {:phoneNumber => @appointment.patient.tel_number, :message => "Ihr Termin bei #{@appointment.medic.title} #{@appointment.medic.name} wurde geändert."[0,50], :serviceURL => appointment_url(@appointment, format: :json)}}
    response = HTTParty.post("http://pushdoc.delphinus.uberspace.de/api/message", options)

    redirect_to({action: :show, id: params[:id]})
  end

  action_item :only => :show do
    link_to('Push changes', :action => :push)
  end

  show do |appointment|
    attributes_table do
      row :title
      row :start
      row :end
      row :patient
      row :medic
      row 'History' do
        ul do
          PublicActivity::Activity.where(trackable:appointment).each do |activity|
            li "#{activity.key} #{activity.parameters.to_json}"
          end
        end
      end
    end
  end

  controller do
    def permitted_params
      params.permit appointment: [:patient_id, :medic_id, :start, :end, :start_date, :start_time_hour, :start_time_minute, :end_date, :end_time_hour, :end_time_minute, :title, :created_at, :updated_at]
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

    alias_method :create_appointment, :create
    def create
        create_appointment

        @appointment.create_activity :create, :owner => current_admin_user
    end
  end
end