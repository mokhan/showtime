class Studio < ActiveRecord::Base
  CastleRock = Studio.find_by_id(1)
  MiramaxFilms = Studio.find_by_id(2)
  RegencyEnterprises = Studio.find_by_id(3)
  Pixar = Studio.find_by_id(4)
  Disney = Studio.find_by_id(5)
end
