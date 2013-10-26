class Appointment < ActiveRecord::Base
  include PublicActivity::Common
  include ActiveModel::Dirty

  belongs_to :patient
  belongs_to :medic

  just_define_datetime_picker :start
  just_define_datetime_picker :end
  validates :start, :presence => true
end
