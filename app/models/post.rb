class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> {order('created_at DESC')}
	validates :title, presence: true, length: {minimum: 5}
	validates :content, presence: true, length: {minimum: 10, maximum: 1000}
	validates :user_id, presence: true

	def public
		Post.where(:private => false)
	end
end
