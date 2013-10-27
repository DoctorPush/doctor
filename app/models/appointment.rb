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

  def title_calendar
    self.patient && "#{self.patient.title} #{self.patient.name}, #{self.patient.prename} #{self.title}"
  end

  def as_json(options={})
    h = super(
      :include => [:patient, :medic ,{:history => {include: [:owner]}}]
    )
    h[:allDay] = false
    h[:title_calendar] = title_calendar
    h[:waiting_persons] = 4
    h
  end

end
