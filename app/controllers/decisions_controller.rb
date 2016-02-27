class DecisionsController < ApplicationController
  def index
    @user_decisions=Decision.where.not(description: "").where(arbiter_id: current_user.arbiter.id)
    @other_decisions=Decision.where.not(arbiter_id: current_user.arbiter.id).where(voting_open: true)
  end

  def new
    if user_signed_in? && current_user.arbiter == nil
      @arbiter=Arbiter.create()
      current_user.arbiter=@arbiter
      @arbiter.save
    end
    @decision=Decision.new
    @firstoption=Firstoption.new
    @secondoption=Secondoption.new
  end

  def create
    @decision=Decision.new(decision_params)
    if user_signed_in?
      current_user.arbiter.decisions << @decision
      @preference = @decision.find_preference()
      # Create Preference if one does not exist
      unless @preference
        puts "=========MAKING PREFERENCE=============="
        @preference=Preference.create(a_score: 1, b_score: 1)
        @decision.arbiter.preferences << @preference
        @decision.type.preferences << @preference
      end
      # make app_choice by calling function on preference
      @decision.app_choice = @preference.make_choice
    else
      # make this take global preferences into account?
      @decision.app_choice = rand(2)
    end
    @decision.description == "" ? @decision.voting_open = false : @decision.voting_open = true
    if @decision.save
      # create first option and give it name from type if user does not specify
      @firstoption=Firstoption.create(description: params[:decision][:firstoption][:description])
      @firstoption.description = @decision.type.possibility_name(0) if @firstoption.description == ""
      # create second option and give it name from type if user does not specify
      @secondoption=Secondoption.create(description: params[:decision][:secondoption][:description])
      @secondoption.description = @decision.type.possibility_name(1) if @secondoption.description == ""
      # attach options to decision
      @decision.firstoption=@firstoption
      @decision.secondoption=@secondoption
      redirect_to edit_decision_path(@decision)
    else
      flash[:notice] = "Invalid Decision"
      redirect_to root_path
    end
  end

  def show
    @vote=Vote.new
    @decision=Decision.find(params[:id])
  end

  def edit
    @decision=Decision.find(params[:id])
  end

  def update
    @decision=Decision.find(params[:id])
    if params[:commit] == "Turn Off Voting"
      @decision.voting_open=false
    elsif params[:commit] == "Turn On Voting"
      @decision.voting_open=true
    else
      @decision.user_choice_assign(params[:commit])
    end    
    if @decision.save
      @decision.log_results_in_preference() if user_signed_in?
      redirect_to decision_path(@decision)
    else
      flash[:notice] = "Could not update Decision"
      redirect_to new_decision_path
    end
  end
  
  def destroy
    Decision.find(params[:id]).destroy
    redirect_to decisions_path
  end

  private

  def decision_params
    params.require(:decision).permit(:type_id, :description)   
  end
end