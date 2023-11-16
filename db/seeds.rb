require 'json'
require 'open-uri'

puts 'Cleaning database'
Bookmark.destroy_all
Movie.destroy_all

url = 'http://tmdb.lewagon.com/movie/top_rated'
movies = URI.open(url).read
info = JSON.parse(movies)
p info

array = info['results']

array.each do |movie|
  one_movie = Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url:"https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts "Creating #{one_movie.title} ....."
end
