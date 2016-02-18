class DecisionsController < ApplicationController
  def index
    @decision=Decision.new
  end

  def new
    @decision=Decision.new
  end

  def create
    @decision=Decision.new(decision_params)
    @decision.dec_type = Decision.type_index(params[:decision][:dec_type])
    @decision.app_choice = rand(2)
    if user_signed_in?
      @decision.user_id = current_user.id
    end
    if @decision.save
      redirect_to decision_path(@decision)
    else
      flash[:notice] = "Invalid Decision"
      redirect_to new_decision_path
    end
  end

  def show
    @decision=Decision.find(params[:id])
  end

  def edit
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
    params.require(:decision).permit(:option_a, :option_b, :choice_description)   
  end
end