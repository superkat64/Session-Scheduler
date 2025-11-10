class Appointment < ApplicationRecord
  belongs_to :client
  has_one :user, through: :client
  has_many :notes, dependent: :destroy
end
