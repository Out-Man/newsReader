class SharedList < ActiveRecord::Base
  belongs_to :users
  has_and_belongs_to_many :articles
  attr_accessible :user_id

  validates :user_id, presence: true, uniqueness: true
end
