json.array!(@medics) do |medic|
  json.extract! medic, :name, :prename, :title
  json.url medic_url(medic, format: :json)
end
