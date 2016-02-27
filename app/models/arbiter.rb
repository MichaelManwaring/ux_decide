class Arbiter < ActiveRecord::Base
	belongs_to :user
	has_many :decisions
	has_many :votes
	has_many :voted_options, through: :votes
	has_many :preferences
end
