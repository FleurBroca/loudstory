class SessionsController < ApplicationController
  before_action :set_exercise
  before_action :set_session, only: [:show, :edit, :destroy]

  def index
    #list of all done exercises
    @sessions = @exercise.sessions.team
  end

  def new
    @user = current_user
    @track = @exercise.track
    # @previous_session = @exercise.sessions.where(user: current_user).first
    @session = @exercise.sessions.new
    @exercises = @exercise.questions.order(position: :asc).each do |question|
      @session.answers.new(question: question)
    end
  end

  def create
    @session = @exercise.sessions.new
    @session.user = current_user
    @session.team = current_team

    exercise = @exercise
    current_track = exercise.track
    nb_exercises = current_user.exercises.select{|ex| ex.track_id == exercise.track.id}.size
    nb_total_exercises = exercise.track.exercises.count
    percentage = nb_exercises.to_f / nb_total_exercises.to_f * 100

    Intercom::Event.create(
      :event_name => "new exercise", :created_at => Time.now,
      :user_id => current_user.id,
      :email => current_user.email,
      :metadata => {
        :exercise_title => "#{exercise.title}",
        :percentage => "#{percentage} %"
      }
    )

    if @session.save
      @exercise.questions.each do |question|
        answer = @session.answers.new(exercise: @exercise, question: question, session: @session, user: current_user, original_question: question.title, position: question.position)
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
  end

  def update
    @session = Session.find(params[:id])
    @exercise = Exercise.find(@session.exercise_id)

    exercise = @exercise
    current_track = exercise.track
    nb_exercises = current_user.exercises.select{|ex| ex.track_id == exercise.track.id}.size
    nb_total_exercises = exercise.track.exercises.count
    percentage = nb_exercises.to_f / nb_total_exercises.to_f * 100

    Intercom::Event.create(
      :event_name => "edit exercise", :created_at => Time.now,
      :user_id => current_user.id,
      :email => current_user.email,
      :metadata => {
        :exercise_title => "#{exercise.title}",
        :percentage => "#{percentage} %"
      }
    )

    # For each answer attribute in params, update the corresponding session
    # We can't go through session_params because it actually creates new answers instead of updating them
    params[:session][:answers_attributes].each do |_, answer_attr|
      @session.answers.find(answer_attr[:id]).update_attribute(:content, answer_attr[:content])
    end

    if @session.valid?
      redirect_to track_path(@session.exercise.track)
    else
      render :edit, notice: 'An error occurred, please try again.'
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to dashboards_index_path, notice: 'Exercise was successfully deleted.'
  end

  def show
  end


  private

    def set_exercise
      @exercise = Exercise.find(params[:exercise_id])
    end

    def set_session
      @session = Session.find(params[:id])
    end

    #def session_params
    #  params.require(:session).permit(answers_attributes: [ :original_question, :content, :question_id, :exercise_id ])
    #end

end
