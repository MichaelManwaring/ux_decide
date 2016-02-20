class Preference < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :type
end
