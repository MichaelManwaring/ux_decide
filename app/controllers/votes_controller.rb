class VotesController < ApplicationController
  def new
  end

  def create
    @decision=Decision.find(params[:format])
    # delete old votes
    flash[:notice] = "Vote Changed!" if current_user.arbiter.votes.where(firstoption_id: @decision.firstoption.id).destroy_all | current_user.arbiter.votes.where(secondoption_id: @decision.secondoption.id).destroy_all
    @vote=Vote.create()
    current_user.arbiter.votes << @vote
    if params[:commit]==@decision.firstoption.description
      @decision.firstoption.votes << @vote
    elsif params[:commit]==@decision.secondoption.description
      @decision.secondoption.votes << @vote
    else
      flash[:notice] = "Bad Vote!"
    end
    unless current_user.arbiter.preferences.where(type: @decision.type).last
        puts "=========MAKING PREFERENCE=============="
        @preference=Preference.create(a_score: 1, b_score: 1)
        current_user.arbiter.preferences << @preference
        @decision.type.preferences << @preference
    end
    @vote.log_results_in_preference()
    redirect_to decision_path(@decision)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
