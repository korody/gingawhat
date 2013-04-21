namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    # Rake::Task['db:reset'].invoke
    make_posts
    make_tags
    # make_microposts
    # make_relationships
  end
end

def make_posts
  99.times do |n|
    title  = Faker::Name.title
    content = Faker::Lorem.paragraphs(6)
    Post.create!(title: title, content: content, user_id: '3', from_city: 'Fortaleza')
  end
end

# def make_authors
#   99.times do |n|
#     name  = Faker::Name.name
#     Author.create!(:name => name)
#   end
# end

def make_tags
  Post.all.each do |post|
    10.times do
      name = Faker::Lorem.word
      post.tags.create!(name: name)
    end
  end
end

# def make_relationships
#   users = User.all
#   user  = users.first
#   following = users[1..50]
#   followers = users[3..40]
#   following.each { |followed| user.follow!(followed) }
#   followers.each { |follower| follower.follow!(user) }
# end