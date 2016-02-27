class Secondoption < ActiveRecord::Base
	belongs_to :decision
	has_many :votes
	has_many :arbiters, through: :votes
end
