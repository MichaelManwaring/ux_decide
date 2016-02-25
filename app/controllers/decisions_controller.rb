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
      @preference = @decision.arbiter.preferences.where(type: @decision.type).last
      # Create Preference if one does not exist
      unless @preference
        puts "=========MAKING PREFERENCE=============="
        @preference=Preference.create(a_score: 1, b_score: 1)
        @decision.arbiter.preferences << @preference
        @decision.type.preferences << @preference
      end
      @decision.app_choice = @preference.make_choice
    else
      # make this take global preferences into account?
      @decision.app_choice = rand(2)
    end
    if @decision.save
      @firstoption=Firstoption.create(description: params[:decision][:firstoption][:description])
      if @firstoption.description == ""
        @firstoption.description = @decision.type.possibility_name(0)
      end
      @secondoption=Secondoption.create(description: params[:decision][:secondoption][:description])
      if @secondoption.description == ""
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
    @decision.user_choice_assign(params[:commit])
    if user_signed_in?  
      # update preference
      @preference = @decision.arbiter.preferences.where(type: @decision.type).last
      @preference.modify_preference(@decision.user_choice)
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