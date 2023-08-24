# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# require "faker"
require "JSON"

puts "Cleaning database..."
Movie.destroy_all

puts "Creating movies..."

# 10.times do
#   Movie.create!(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.paragraph(sentence_count: 4),
#     poster_url: Faker::LoremFlickr.image(size: "50x60", search_terms: ['movies']),
#     rating: rand(1.0..10.0)
#   )
# end

# API key: d5b8dd28dbdc765030324d1fdfdb1cde
# URL: http://tmdb.lewagon.com./movie/top_rated?api_key=d5b8dd28dbdc765030324d1fdfdb1cde

# URL de l'API TMDb
tmdb_url = "http://tmdb.lewagon.com/movie/top_rated?api_key=d5b8dd28dbdc765030324d1fdfdb1cde"

# Effectuer une requête GET et récupérer les données JSON
response = URI.open(tmdb_url)
movies_data = JSON.parse(response.read)

# Créer un fichier de vue pour formater les données JSON
jbuilder_template = Jbuilder.new do |json|
  json.array! movies_data['results'] do |movie_data|
    json.title movie_data['title']
    json.overview movie_data['overview']
    json.poster_url "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}"
    json.rating movie_data['vote_average']
  end
end

# Créer des films à partir des données formatées
jbuilder_result = JSON.parse(jbuilder_template.target!)
jbuilder_result.each do |movie_data|
  Movie.create!(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: movie_data['poster_url'],
    rating: movie_data['rating']
  )
end

puts "Finished!"
