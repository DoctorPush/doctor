class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :medic

  just_define_datetime_picker :start
  just_define_datetime_picker :end
  validates :start, :presence => true
end
