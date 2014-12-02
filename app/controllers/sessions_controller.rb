class SessionsController < ApplicationController
  before_action :set_exercise

  def new
    @user = current_user
    @previous_sessions = @exercise.sessions.where(user: current_user)
    @session = @exercise.sessions.new
    @exercises = @exercise.questions.each do |question|
      @session.answers.new(question: question)
    end
    # @exercises.questions.order(:position)
  end

  def create
    @session = @exercise.sessions.new
    @session.user = current_user

    if @session.save
      @exercise.questions.each do |question|
        answer = @session.answers.new(exercise: @exercise, question: question, session: @session, user: current_user, original_question: question.title)
        answer.content = params[:session][:answers_attributes][(answer.question.position - 1).to_s][:content]
      end

      if @session.save
       redirect_to track_path(@exercise.track)
      else
        render :new
      end
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def update
    @session = Session.find(params[:id])

    if @session.update(session_params)
      redirect_to dashboards_index_path
    else
      render :edit, notice: 'An error occurred, please try again.'
    end
  end



  def index
    #list of all done exercises
    @sessions = @exercise.sessions
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to dashboards_index_path, notice: 'Exercise was successfully deleted.'
  end


  private

    def set_exercise
      @exercise = Exercise.find(params[:exercise_id])
    end

    def session_params
      params.require(:session).permit(answers_attributes: [ :original_question, :content, :question_id, :exercise_id ])
    end

end
