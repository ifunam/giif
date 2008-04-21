class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
    @user = User.new
  end

  def signup
    if User.authenticate?(params[:user][:login], params[:user][:password])
      flash[:notice] = 'Bienvenido (a)!'
      session[:user] = User.find_by_login(params[:user][:login]).id
      respond_to do |format|
        default = 'order_requests'
        format.html { session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(:controller => default) }
      end
   else
      flash[:notice] = 'El login o password es incorrecto!'
      respond_to do |format|
        format.html { redirect_to :action =>:index }
      end
   end
  end

  def destroy
    reset_session
    render :action => :logout
  end
end
