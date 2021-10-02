class Contact < ApplicationRecord
  belongs_to :contact_file

  enum status: { succeeded: 0, failed: 1 }

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9 -]*\z/, multiline: true }, if: :succeeded?
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :succeeded?
  validates :phone, presence: true, format: {with: /\A\(\+\d{2}\) \d{3}([- ])\d{3}\1\d{2}\1\d{2}\z/}, if: :succeeded?
  validates :address, presence: true, if: :succeeded?
  validates :credit_card, presence: true, if: :succeeded?
  validates :date_of_birth, presence: true, if: :succeeded?
  validates_each :date_of_birth_before_type_cast, if: :succeeded? do |record, attribute, value|
    value.include?("-") ? Date.strptime(value, "%F") : Date.strptime(value, "%Y%m%d")
  rescue
    record.errors.add(:date_of_birth, :invalid)
  end

  after_initialize { status = :succeeded if new_record? }
end
