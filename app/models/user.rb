class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers
  has_many :sessions

  has_attached_file :picture,
    styles: { profile: "100x100#", nav: "30x30#" }, :default_url => "http://placehold.it/200&text=user"

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  validates_presence_of :email, :encrypted_password


  def exercises
    self.sessions.map{ |session| session.exercise }.uniq
  end


  def last_sessions(session)
    track = session.track
    exercises_in_track = self.exercises.select { |e| e.track_id == track.id && e.position != session.exercise.position }

    grouped_exercises = exercises_in_track.group_by { |e| e.position }
    grouped_exercises.map do |position, exercises|
      exercises.last.sessions.order(:updated_at).limit(1).last
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end
end
