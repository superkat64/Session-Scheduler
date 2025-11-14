class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :appointments, through: :clients

  validates :email_address,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
