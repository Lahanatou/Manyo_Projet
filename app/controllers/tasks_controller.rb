class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_expired]
      @tasks=current_user.tasks.orderByDeadline.kaminari(params[:page])
    elsif
    @tasks=current_user.tasks.orderByPriority.kaminari(params[:page])
    else
    #@tasks = Task.all
    @tasks =current_user.tasks.orderByCreated_at .kaminari(params[:page])
  end
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end


  # GET /tasks/1 or /tasks/1.json
  def show
  @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @label = @task.labelings.build
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # GET /tasks/1/edit
  def edit
      @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.new(task_params)
#@task.status= @task.status-1
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      @task = Task.find(params[:id])
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json


  def destroy
    @task = Task.find params[:id]
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
      session[:search] = {'title' => params[:search_title], 'status' => params[:search_status],'label'=>params[:search_label]}
       @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
      @tasks = researched.ordered
      @search_title = session[:search]['title']
      puts"hhhhhhhhhhhhhhhh"
      puts @search_title
      puts"hhhhhhhhhhhhhhhh"
      render :index

    end

    def sort
          @tasks = researched.ordered
          @search_title = session[:search]['title']  if session[:search].present?
          @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
          session[:search] = nil
          render :index
        end

        def researched
                if session[:search].present?
                  if session[:search]['title'].blank? && session[:search]['status'].blank? && session[:search]['label'].blank?

                  #Task.all.kaminari(params[:page])
                  Task.current_user_sort(current_user.id).kaminari(params[:page])
                else
                  tasks = Task.all


                  if session[:search]['title'].present?
                    tasks = tasks.title_sort(session[:search]['title']).kaminari(params[:page])

                  end

                  if session[:search]['status'].present?
                    tasks = tasks.status_sort(session[:search]['status']).kaminari(params[:page])
                  end
                  if session[:search]['label'].present?
                    tasks = tasks.label_sort(session[:search]['label']).kaminari(params[:page])
                  end
                    tasks.kaminari(params[:page])
                  end
                end
              end


  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content,:deadline,:priority,:status, label_ids: [])
    end
end
