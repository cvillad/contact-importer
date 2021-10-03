class Contact < ApplicationRecord
  require 'credit_card_validations/string'
  include CreditCardMethods

  PHONE_REGEX = /\A\(\+\d{2}\) \d{3}([- ])\d{3}\1\d{2}\1\d{2}\z/.freeze
  NAME_REGEX = /\A[a-zA-Z0-9 -]*\z/.freeze

  enum status: { succeeded: 0, failed: 1 }

  belongs_to :contact_file

  validates :name, presence: true, format: { with: NAME_REGEX , multiline: true }, if: :succeeded?
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :succeeded?
  validates :phone, presence: true, format: {with: PHONE_REGEX }, if: :succeeded?
  validates :address, presence: true, if: :succeeded?
  validates :credit_card, presence: true, credit_card_number: true, if: :succeeded?
  validates :date_of_birth, presence: true, if: :succeeded?
  validates_each :date_of_birth_before_type_cast, if: :succeeded? do |record, attribute, value|
    value.include?("-") ? Date.strptime(value, "%F") : Date.strptime(value, "%Y%m%d")
  rescue
    record.errors.add(:date_of_birth, :invalid)
  end

  after_initialize { status = :succeeded if new_record? }

  before_save :save_credit_card
end
