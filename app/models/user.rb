class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :send_welcome_email

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers
  has_many :sessions
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :comments, dependent: :destroy

  has_attached_file :picture,
    styles: { profile: "100x100#", nav: "30x30#" }, :default_url => "http://placehold.it/200&text=user"

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  validates_presence_of :email, :encrypted_password
  # accepts_nested_attributes_for :team, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true


  # def getsessions(team)
    # self.sessions.where(:team team)
  # end
#
  # def exercises(team)
    # team_sessions = self.getsessions(team)
    # team_sessions.map{ |session| session.exercise }.uniq.compact
  # end

  def exercises
    self.sessions.map{ |session| session.exercise }.uniq.compact
  end

  # Retrives an array of sessions for each exercise the user has already completed
  def last_sessions(cur_session, user)
    track = cur_session.track
    # We get all the exercises for the user based on their belonging to one track and their position
    exercises_in_track = self.exercises.select { |e| e.track_id == track.id && e.position != cur_session.exercise.position }

    # An has with the format { position => array_of_exercises }.
    # e.g : { 1 => [Exo1, Exo2], 2 => [Exo1, Exo2] }
    grouped_exercises = exercises_in_track.group_by { |e| e.position }

    # We retrieve the last session (last trial of an exercise) for each exercise
    grouped_exercises.map do |position, exercises|
      exercises.last.user_sessions(user).order(:updated_at).limit(1).last
    end
  end

  def last_team_sessions(cur_session, user, current_team)
    track = cur_session.track
    # We get all the exercises for the user based on their belonging to one track and their position
    exercises_in_track = self.exercises.select { |e| e.track_id == track.id && e.position != cur_session.exercise.position }

    # An has with the format { position => array_of_exercises }.
    # e.g : { 1 => [Exo1, Exo2], 2 => [Exo1, Exo2] }
    grouped_exercises = exercises_in_track.group_by { |e| e.position }

    # We retrieve the last session (last trial of an exercise) for each exercise
    grouped_exercises.map do |position, exercises|
      exercises.last.team_sessions(current_team).order(:updated_at).limit(1).last
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end
end
