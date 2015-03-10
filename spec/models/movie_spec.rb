require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { Movie.new }
  let(:shawshank_redemption) { create_movie(title: "The Shawshank Redemption", studio: Studio::CastleRock, year: 1994) }
  let(:chasing_amy) { create_movie(title: "Chasing Amy", studio: Studio::MiramaxFilms, year: 1997) }
  let(:man_on_fire) { create_movie(title: "Man on Fire", studio: Studio::RegencyEnterprises, year: 2004) }

  let(:toy_story) { create_movie(title: "Toy Story", studio: Studio::Pixar, year: 1995) }
  let(:up) { create_movie(title: "Up", studio: Studio::Pixar, year: 2006) }
  let(:cars) { create_movie(title: "Cars", studio: Studio::Pixar, year: 2009) }
  let(:monsters_inc) { create_movie(title: "Monsters Inc.", studio: Studio::Pixar, year: 2001) }

  let(:fantasia) { create_movie(title: "Fantasia", studio: Studio::Disney, year: 1940) }
  let(:dumbo) { create_movie(title: "Dumbo", studio: Studio::Disney, year: 1941) }
  let(:pinocchio) { create_movie(title: "Pinocchio", studio: Studio::Disney, year: 1940) }

  let(:all_movies) { [shawshank_redemption, chasing_amy, man_on_fire, toy_story, up, cars, monsters_inc, fantasia, dumbo, pinocchio] }

  def create_movie(details)
    Movie.new(details)
  end

  context "when adding a movie to the movie" do
    it "increases the total number of movies in the movie" do
      shawshank_redemption.save!
      chasing_amy.save!
      expect(Movie.count).to eql(2)
    end

    it "does not allow duplicate movies into the library" do
      man_on_fire.save
      man_on_fire.save
      expect(Movie.count).to eql(1)
    end

    it 'cannot add two movies that have the same title (logically the same)' do
      create_movie(:title => 'Old School').save
      create_movie(:title => 'Old School').save
      expect(Movie.count).to eql(1)
    end

    it "will not create a movie that is missing a title" do
      create_movie(:title => nil).save
      expect(Movie.count).to eql(0)
    end
  end

  context 'Searching for movies' do
    before :each do
      all_movies.each { |movie| movie.save! }
    end

    it 'Can find all pixar movies' do
      results = Movie.all
      expect(results.count).to eq(4)
      expect(results).to include(toy_story)
      expect(results).to include(up)
      expect(results).to include(cars)
      expect(results).to include(monsters_inc)
    end

    it 'Can find all movies published by pixar or disney' do
      results = Movie.all
      expect(results.count).to eq(7)
      expect(results).to include(toy_story)
      expect(results).to include(up)
      expect(results).to include(cars)
      expect(results).to include(monsters_inc)
      expect(results).to include(fantasia)
      expect(results).to include(dumbo)
      expect(results).to include(pinocchio)
    end

    it 'Can find all movies not published by pixar' do
      results = Movie.all
      expect(results.length).to eq(6)
      expect(results).to include(fantasia)
      expect(results).to include(dumbo)
      expect(results).to include(pinocchio)
      expect(results).to include(shawshank_redemption)
      expect(results).to include(chasing_amy)
      expect(results).to include(man_on_fire)
    end

    it 'Can find all movies released after 2004' do
      results = Movie.all
      expect(results.length).to eq(2)
      expect(results).to include(up)
      expect(results).to include(cars)
    end

    it 'Can find all movies released between 1982 and 2003 - Inclusive' do
      results = Movie.all
      expect(results.length).to eq(4)
      expect(results).to include(shawshank_redemption)
      expect(results).to include(chasing_amy)
      expect(results).to include(toy_story)
      expect(results).to include(monsters_inc)
    end
  end

  context 'Sorting movies' do
    before :each do
      all_movies.each { |x| x.save! }
    end

    it 'Sorts all movies by ascending title' do
      expected_order = [ cars, chasing_amy, dumbo, fantasia, man_on_fire, monsters_inc, pinocchio, shawshank_redemption, toy_story, up]
      results = Movie.all
      expect(results).to eq(expected_order)
    end

    it 'Sorts all movies by descending title' do
      expected_order = [up, toy_story, shawshank_redemption, pinocchio, monsters_inc, man_on_fire, fantasia, dumbo, chasing_amy, cars]
      results = Movie.all
      expect(results).to eq(expected_order)
    end

    it 'Sorts all movies by descending release date' do
      expected_order = [cars, up, man_on_fire, monsters_inc, chasing_amy, toy_story, shawshank_redemption, dumbo, fantasia, pinocchio ]
      results = Movie.all
      expect(results).to eq(expected_order)
    end

    it 'Sorts all movies by ascending release date' do
      expected_order = [ fantasia, pinocchio, dumbo, shawshank_redemption, toy_story, chasing_amy, monsters_inc, man_on_fire, up, cars]
      results = Movie.all
      expect(results).to eq(expected_order)
    end

    it 'Sorts all movies by preferred studios and release date ascending' do
      #rankings: Pixar, Disney, CastleRock, MiramaxFilms, RegenceyEnterprises
      expected_order = [ toy_story, monsters_inc, up, cars, fantasia, pinocchio, dumbo, shawshank_redemption, chasing_amy, man_on_fire]
      results = Movie.sort_movies_by_preferred_studios_and_release_date_ascending
      expect(results).to eq(expected_order)
    end
  end
end
