class Api::V1::TaskListsController < ApplicationController

  def index
    respond_with TaskList.all
  end
end
