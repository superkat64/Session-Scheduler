class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :appointments, through: :clients

  before_validation :normalize_email

  validates :email_address,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def normalize_email
    self.email_address = email_address.strip.downcase if email_address.present?
  end
end
