class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
    @user = User.new
  end

  def signup
    if  User.authenticate?(params[:user][:login] , params[:user][:password])
      flash[:notice] = 'Bienvenido wey!'
      session[:user] = User.find_by_login(params[:user][:login]).id
      respond_to do |format|
        format.html {     redirect_to :controller => :groups,  :action=> :index }
      end
      #redirect_to :controller => :groups,  :action=> :index

   else
      flash[:notice] = 'El login o password es incorrecto (wey)!'
      respond_to do |format|
        format.html {redirect_to :action =>:index}
      end
      #redirect_to :action =>:index
   end
  end

  def destroy
    reset_session
    render :action => :logout
  end
end
