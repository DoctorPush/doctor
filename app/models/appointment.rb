class Appointment < ActiveRecord::Base
  include PublicActivity::Common
  include ActiveModel::Dirty

  belongs_to :patient
  belongs_to :medic

  just_define_datetime_picker :start
  just_define_datetime_picker :end
  validates :start, :presence => true

  def history
  	PublicActivity::Activity.where(trackable:self)
  end

  def as_json(options={})
    super(
      :include => [:patient, :medic , {:history => {include: [:owner]}}]
    )
  end

end
