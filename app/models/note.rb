class Note < ApplicationRecord
  belongs_to :appointment
  has_one :client, through: :appointment
  has_one :user, through: :client

  validates :content, presence: true, length: { minimum: 2, maximum: 2000 }

  before_save :strip_whitespace

  private

  def strip_whitespace
    self.content = content.strip if content.present?
  end
end