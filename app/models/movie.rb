class Movie < ActiveRecord::Base
  belongs_to :studio

  def self.sort_movies_by_preferred_studios_and_release_date_ascending
    all
  end
end
