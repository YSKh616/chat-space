class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :group
  validates :body, presence: true, unless: :image?
  validates :user_id, :group_id, presence: true
end
