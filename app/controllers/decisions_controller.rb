class DecisionsController < ApplicationController
  def index
    @decisions=Decision.all
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
      # make this take preferences into account
      @decision.app_choice = rand(2)
    else
      # make this take global preferences into account?
      @decision.app_choice = rand(2)
    end
    if @decision.save
      @firstoption=Firstoption.create(description: params[:decision][:firstoption][:description])
      if @firstoption.description == nil
        @firstoption.description = @decision.type.possibility_name(0)
      end
      @secondoption=Secondoption.create(description: params[:decision][:secondoption][:description])
      if @secondoption.description == nil
        @secondoption.description = @decision.type.possibility_name(1)
      end
      @decision.firstoption=@firstoption
      @decision.secondoption=@secondoption
      redirect_to edit_decision_path(@decision)
    else
      flash[:notice] = "Invalid Decision"
      redirect_to root_path
    end
  end

  def show
    @decision=Decision.find(params[:id])
  end

  def edit
    @decision=Decision.find(params[:id])
  end

  def update
    @decision=Decision.find(params[:id])
    if params[:commit] == "I took your advice"
      @decision.user_choice = @decision.app_choice
    elsif params[:commit] == "Actually, I'm going with the other one"
      if @decision.app_choice == 0
        @decision.user_choice = 1
      elsif @decision.app_choice == 1
        @decision.user_choice = 0
      else
        flash[:notice] = "bad commit"
      end
    end
    if @decision.save
      redirect_to decision_path(@decision)
    else
      flash[:notice] = "Could not update Decision"
      redirect_to new_decision_path
    end
  end

  def destroy
  end

  private

  def decision_params
    params.require(:decision).permit(:type_id, :description)   
  end
end