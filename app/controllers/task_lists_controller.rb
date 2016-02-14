class TaskListsController < ApplicationController
  before_action :load_task_list, only: [:destroy, :update]
  # before_action :authenticate_user!
  # authorize_resource
  
  def index
    # respond_with current_user.task_lists
    respond_with TaskList.all
  end

  def create
    # @task_list = current_user.task_lists.create(task_list_params)
    @task_list = TaskList.create(task_list_params)
    respond_with @task_list
  end

  def update
    @task_list.update(task_list_params)
    respond_with @task_list
  end

  def destroy
    respond_with @task_list.destroy
  end

  private

  def task_list_params
    params.require(:task_list).permit(:title)
  end

  def load_task_list
    @task_list = TaskList.find(params[:id])
  end
end
