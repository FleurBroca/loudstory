module TrackHelper
  def alltracks
    Track.all.order(:position)
  end
end
