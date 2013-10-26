json.array!(@patients) do |patient|
  json.extract! patient, :name, :prename, :title, :record_id, :address, :tel_number
  json.url patient_url(patient, format: :json)
end
