class Client < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  validates :first_name, :last_name, :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
