class Secondoption < ActiveRecord::Base
	belongs_to :decision
	has_many :votes
end
