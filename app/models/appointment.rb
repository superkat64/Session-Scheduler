class Appointment < ApplicationRecord
  belongs_to :client
  has_one :user, through: :client
  has_many :notes, dependent: :destroy
  validates :scheduled_at, presence: true

  def formatted_scheduled_at
    scheduled_at.strftime("%b %d, %Y at %I:%M %p")
  end
end
