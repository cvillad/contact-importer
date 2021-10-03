class User < ApplicationRecord
  scope :succeeded, -> { where(status: :succeeded) }
  scope :failed, -> { where(status: :failed) }

  has_many :contact_files, dependent: :destroy
  has_many :contacts, through: :contact_files

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
