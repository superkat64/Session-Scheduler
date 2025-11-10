class Appointment < ApplicationRecord
  belongs_to :client
  has_one :user, through: :client
  has_many :notes, dependent: :destroy
  validates :scheduled_at, presence: true
end
