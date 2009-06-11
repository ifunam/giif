class ProjectsController < ApplicationController

  def destroy
    @record = Project.find(params[:id])
    @record.destroy
    respond_to do |format|
      format.js { render 'destroy.rjs' }
    end
  end
end
