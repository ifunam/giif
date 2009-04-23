class FilesController < ApplicationController
skip_before_filter :login_required
before_filter :session_provider_required

  def index
    @files = OrderFile.all(:conditions => ['order_id = ? AND provider_id = ?', params[:id], session[:provider_id]])
    respond_to do |format|
      format.html { render 'index.html.haml'}
    end
  end

  def update
    @file = OrderFile.new(params[:order_file])
    respond_to do |format|
      if @file.save
        format.html { render :text => 'Su archivo ha sido guardado' }
      else
        format.html { render :action => 'new'}
      end
    end
  end

  def show
#    @order
#    @provider
  end

  def destroy
  end

  def notify_to_user
    #upload file
    #notify to user by e-mail
  end

  private
  def session_provider_required
     (!session[:provider_id].nil? and !Provider.find(session[:provider_id]).nil?) ? (return true) : (return false)
  end

end
