class Vote < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :option
end
