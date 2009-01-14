class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
    @user = User.new
  end

  def signup
    if User.authenticate?(params[:user][:login], params[:user][:password])
#    if AuthenticationClient.authenticate?(params[:user][:login], params[:user][:password])
      flash[:notice] = 'Bienvenido(a)!'
      session[:user] = User.find_by_login(params[:user][:login]).id
      options = session[:return_to] ?  session[:return_to] : { :controller => 'order_requests',  :action => 'index'}
   else
      flash[:notice] = 'El login o password es incorrecto!'
      options = { :action =>:index }
   end
    respond_to do |format|  format.html { redirect_to options } end
  end

  def destroy
    reset_session
    render :action => :logout
  end
end
