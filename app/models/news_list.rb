class NewsList < ActiveRecord::Base
  has_and_belongs_to_many :articles
  belongs_to :user
  attr_accessible :name, :articles

  validates :user_id, presence: true
  validates :name, presence: true
end
