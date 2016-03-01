class Decision < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :type
	has_one :firstoption
	has_one :secondoption
	has_many :votes, through: :firstoption
	has_many :votes, through: :secondoption


	def display_app_choice
		if self.app_choice == 0
			return self.firstoption.description
		elsif self.app_choice ==1 
			return self.secondoption.description
		else
			return "No choice made"
		end
	end
	def display_user_choice
		if self.user_choice == 0
			return self.firstoption.description
		elsif self.user_choice ==1 
			return self.secondoption.description
		else
			return "No choice made"
		end
	end
	
	def user_choice_assign(commit)
		if commit == "I took your advice"
			self.user_choice = self.app_choice
		elsif commit == "I'm going with the other one"
			if self.app_choice == 0
				self.user_choice = 1
			elsif self.app_choice == 1
				self.user_choice = 0
			else
				flash[:notice] = "bad commit"
			end
		end			
	end	

	def log_results_in_preference
		# update preference
	    @preference = self.arbiter.preferences.where(type: self.type).last
	    @preference.modify_preference(self.user_choice)
	end
	def name
		self.firstoption.description + " or " + self.secondoption.description
	end
	def find_preference
		self.arbiter.preferences.where(type: self.type).last
	end

	def voting_percent(option)
		if self.total_votes() == 0
			return 50
		end
		if option == 0
			100*self.firstoption.votes.count()/(self.firstoption.votes.count() + self.secondoption.votes.count())
		elsif option ==1
			100*self.secondoption.votes.count()/(self.firstoption.votes.count() + self.secondoption.votes.count())
		else
			return "BAD SELECT"
		end
		
	end
	def total_votes
		self.firstoption.votes.count() + self.secondoption.votes.count()
	end
end
