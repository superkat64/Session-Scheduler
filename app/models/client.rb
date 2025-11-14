class Client < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A\+?[0-9]{7,15}\z/, message: "must be a valid phone number" }

  before_validation :normalize_email, :normalize_phone, :normalize_names

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end

  def normalize_phone
    self.phone = self.phone = phone.gsub(/[^0-9+]/, "") if phone.present?
  end

  def normalize_names
    self.first_name = first_name.downcase.strip.titleize if first_name.present?
    self.last_name = last_name.downcase.strip.titleize if last_name.present?
  end
end
