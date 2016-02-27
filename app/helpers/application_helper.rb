module ApplicationHelper
	def current_users_decision
		if user_signed_in? && current_user.arbiter == @decision.arbiter
			true
		end
	end

end
