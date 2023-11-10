class Post < ApplicationRecord
  belongs_to :user 
  belongs_to :photo 
  has_many :upvotes
end
