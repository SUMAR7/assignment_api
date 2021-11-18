# frozen_string_literal: true
require 'faker'
require_relative '../app/models/user'
require_relative '../app/models/Post'
require_relative '../app/models/feedback'

puts 'Creating 50 random IP addresses'
ip_addresses = []
50.times do
  ip_addresses.push(Faker::Internet.unique.ip_v4_address)
end
puts 'CREATED 50 random IP addresses'


time = Time.now

puts 'Creating 100 Authors'
puts 'Preparing data'
authors = []
100.times do
  authors.push({ username: Faker::Name.unique.name, created_at: time, updated_at: time })
end
puts 'Authors Data Prepared'
puts 'Inserting Authors to Database'
authors = User.insert_all(authors)
puts '100 Authors Created'

puts 'Creating 200,000 Posts'
puts 'Preparing data'
posts = []
200_000.times do
  posts.push({ title: Faker::Book.title,
               content: Faker::Movie.quote,
               ip_address: ip_addresses.sample,
               user_id: authors.rows.sample&.first,
               created_at: time,
               updated_at: time
             })
end
puts 'Posts Data Prepared'
puts 'Inserting Posts to Database'
posts = Post.insert_all(posts)
puts '200,000 Posts Created'

puts 'Creating 10,050 Feedback'
puts 'Preparing data'
feedbacks = []
10_000.times do
  feedbacks.push({ comment: Faker::Movie.quote,
                   owner_id: Faker::Internet.email,
                   feedbackable_id: posts.rows.sample&.first,
                   feedbackable_type: 'Post',
                   created_at: time,
                   updated_at: time
                 })
end

50.times do
  feedbacks.push({ comment: Faker::Movie.quote,
                   owner_id: Faker::Internet.email,
                   feedbackable_id: authors.rows.sample&.first,
                   feedbackable_type: 'User',
                   created_at: time,
                   updated_at: time
                 })
end
puts 'Feedback Data Prepared'
puts 'Inserting Feedback to Database'
Feedback.insert_all(feedbacks)
puts '10,050 Feedbacks Created'

