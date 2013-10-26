json.array!(@appointments) do |appointment|
  json.extract! appointment, :start, :end, :patient_id, :medic_id
  json.url appointment_url(appointment, format: :json)
end
