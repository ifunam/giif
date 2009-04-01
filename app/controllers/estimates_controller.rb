class EstimatesController < ApplicationController
  def index
      @user_profile = user_profile
      @collection = Order.paginate_unsent_by_user_id(session[:user], params[:page], params[:per_page])
      respond_to do |format|
        format.html { render :index }
      end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
