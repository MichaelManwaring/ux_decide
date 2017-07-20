class Preference < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :type

	def modify_preference(a_or_b)
		if a_or_b == 0
			self.a_score += 1
		elsif a_or_b == 1
			self.b_score += 1
		end
		self.save!
	end
	def explain_preference_a
		if self.a_score == 1 && self.b_score == 1
			@percentage = 50
		else
			@percentage = 100*(self.a_score-1) / (self.a_score + self.b_score-2)
		end
	end
	def explain_preference_b
		if self.a_score == 1 && self.b_score == 1
			@percentage = 50
		else
			@percentage = 100*(self.b_score-1) / (self.a_score + self.b_score-2)
		end
	end
	def make_choice
		@coinflip=rand(self.a_score + self.b_score + 1)
        puts @coinflip
        if @coinflip < self.a_score
          return 0
        elsif @coinflip >= self.a_score
          return 1
        end
    end
end
