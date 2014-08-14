class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	default_scope -> {order('created_at DESC')}
	validates :body, presence: true, length: {minimum: 4, maximum: 500}
	validates :user_id, presence: true
end
