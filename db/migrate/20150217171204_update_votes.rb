class UpdateVotes < ActiveRecord::Migration
  def change

    Vote.create(count_landing: 0, count_press: 0, count_pitch: 0)

  end
end
