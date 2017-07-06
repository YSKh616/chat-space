class Group < ApplicationRecord
  validates :name, presence: true
  has_many :users, through: :groups_users
  has_many :groups_users
  has_many :messages

  def find_last_message
    unless messages.empty?
      messages.last.body
    else
      "まだメッセージはありません。"
    end
  end
end
