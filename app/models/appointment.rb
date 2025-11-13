class Appointment < ApplicationRecord
  belongs_to :client
  has_one :user, through: :client
  has_many :notes, dependent: :destroy

  enum :location, { office: 0, virtual: 1, phone: 2 }
  enum :status,   { scheduled: 0, completed: 1, canceled: 2, no_show: 3 }

  validates :scheduled_at, comparison: { greater_than: Time.current }
  validates :location, :status, presence: true
  validates :duration_minutes, numericality: { greater_than: 0 }


  def formatted_scheduled_at
    scheduled_at.strftime("%b %d, %Y at %I:%M %p")
  end
end
