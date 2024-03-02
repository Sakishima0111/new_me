class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :goal
    
    validates :body, presence: true
end
