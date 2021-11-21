class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[complete update destroy]

  def create
    @task = Task.new(task_params)
    @task.save
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  def complete
    @task.update(completed: true)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :project_id)
  end
end
