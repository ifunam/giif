class Budget::SessionsController < SessionsController

  def signup
    respond_to do |format|
      if User.authenticate?(params[:user][:login], params[:user][:password]) #and User.is_budget_admin? params[:user][:login]
        session[:user] = User.find_by_login(params[:user][:login]).id
        flash[:notice] = "Bienvenido(a)!"
        format.html { redirect_to(budget_order_requests_url) }
      else
        flash[:notice] = "El login o password es incorrecto!"
        format.html { render :action => "index" }
      end
    end
  end

#   private
#   def authenticate?(user,passwd)
#     begin
#       return true if Net::SSH.start("fenix.fisica.unam.mx", user, :password => passwd)
#     rescue StandardError => bang
#       return false
#     end
#   end
end
