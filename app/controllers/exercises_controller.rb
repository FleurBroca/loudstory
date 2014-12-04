class ExercisesController < ApplicationController


  private
  def exercise_params
    params.require(:exercise).permit(:title, :description, :photo)
  end
end
