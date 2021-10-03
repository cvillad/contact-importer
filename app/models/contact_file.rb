class ContactFile < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, finished: 3 }

  delegate :filename, to: :file

  belongs_to :user

  has_one_attached :file
  has_many :contacts, dependent: :destroy

  validates :headers, presence: true
  validates :file, attached: true, content_type: ['text/csv']

  after_initialize { status = :on_hold if new_record? }

  def file_path
    file.blob.service.name == :local ? ActiveStorage::Blob.service.send(:path_for, file.blob.key) : file.service_url
  end
end
