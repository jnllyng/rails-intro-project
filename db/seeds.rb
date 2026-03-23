require 'net/http'
require 'json'
require 'csv'

# Genres
genres = [
  { name: "Fiction", description: "Imaginative and narrative literature" },
  { name: "Non-Fiction", description: "Factual and informative literature" },
  { name: "Science Fiction", description: "Speculative fiction based on science" },
  { name: "Mystery", description: "Stories involving crime and suspense" },
  { name: "Romance", description: "Stories centered on love and relationships" },
  { name: "Biography", description: "Life stories of real people" },
  { name: "Fantasy", description: "Stories set in magical or supernatural worlds" },
  { name: "History", description: "Books about historical events and periods" },
  { name: "Self-Help", description: "Books for personal development" },
  { name: "Horror", description: "Stories designed to frighten and disturb" }
]

genres.each do |g|
  Genre.find_or_create_by(name: g[:name]) do |genre|
    genre.description = g[:description]
  end
end

# Books from OpenAPI
subjects = [ "fiction", "mystery", "romance", "science_fiction", "fantasy" ]

subjects.each do |subject|
  uri = URI("https://openlibrary.org/subjects/#{subject}.json?limit=20")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  next unless data["works"]

  data["works"].each do |work|
    author_name = work.dig("authors", 0, "name") || "Unknown Author"
    author = Author.find_or_create_by(name: author_name) do |a|
      a.bio = Faker::Lorem.paragraph
      a.nationality = Faker::Address.country
    end

    genre = Genre.all.sample

    Book.find_or_create_by(title: work["title"]) do |b|
      b.description = Faker::Lorem.paragraph(sentence_count: 4)
      b.cover_image = work["cover_id"] ? "https://covers.openlibrary.org/b/id/#{work["cover_id"]}-M.jpg" : nil
      b.published_year = work["first_publish_year"] || rand(1950..2023)
      b.pages = rand(150..800)
      b.rating = rand(3.0..5.0).round(1)
      b.genre = genre
      b.author = author
    end
  end
end

# Reviews with Faker
Book.all.each do |book|
  rand(2..5).times do
    Review.create!(
      book: book,
      reviewer_name: Faker::Name.name,
      body: Faker::Lorem.paragraph(sentence_count: 3),
      rating: rand(1.0..5.0).round(1)
    )
  end
end
