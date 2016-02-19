class DecisionsController < ApplicationController
  def index
    @decisions=Decision.all.where(dec_type: 6)
  end

  def new
    @decision=Decision.new
  end

  def create
    if Decision.type_index(params[:decision][:dec_type]) == nil
      flash[:notice] = "Invalid Decision"
      redirect_to root_path
    else
      @decision=Decision.new(dec_type: Decision.type_index(params[:decision][:dec_type]))
      @decision.app_choice = rand(2)
      if user_signed_in?
        @decision.user_id = current_user.id
      end
      if @decision.save
        if @decision.dec_type == 6
          redirect_to edit_decision_path(@decision)
        else
          redirect_to decision_path(@decision)
        end
      else
        flash[:notice] = "Invalid Decision"
        redirect_to root_path
      end
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
    elsif params[:commit] == "Create Custom Decision"
      @decision.update(custom_decision_params)
      @decision.update(a_count: 0, b_count: 0)
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

  def custom_decision_params
    params.require(:decision).permit(:option_a, :option_b, :description)   
  end
end