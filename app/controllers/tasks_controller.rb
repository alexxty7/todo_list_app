class TasksController < ApplicationController
  before_action :load_task, except: :create
  before_action :authenticate_user!
  authorize_resource
  
  def show
    respond_with @task
  end

  def create
    @task = Task.create(task_params)
    respond_with @task
  end

  def update
    if params[:position]
      @task.set_list_position(params[:position].to_i + 1)
    else
      @task.update(task_params)
    end
    respond_with @task
  end

  def destroy
    respond_with @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed, :position, :deadline, :task_list_id)
  end

  def load_task
    @task = Task.find(params[:id])
  end

end