class FeedsList < ActiveRecord::Base
  has_and_belongs_to_many :feeds
  belongs_to :user
  attr_accessible :is_private, :name, :feeds
  attr_accessor :feeds_url

  validates :user_id, presence: true
  validates :name, presence: true
end
