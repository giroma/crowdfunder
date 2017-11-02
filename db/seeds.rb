Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all

categories = ['Art', 'Comics', 'Crafts', 'Dance', 'Design', 'Fashion', 'Film & Video', 'Food', 'Games', 'Journalism', 'Music', 'Photography', 'Publishing', 'Technology', 'Theater']

categories.each do |category|
  Category.create(name: category)
end

20.times do
  project = Project.create!(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph(3),
              goal: rand(40000),
              start_date: Time.now.utc - rand(60).days,
              end_date: Time.now.utc + rand(10).days,
              user_id: rand(1..5),
              image: "https://picsum.photos/1280/720?image=#{rand(2..100)}",
              category_id: rand(1..15)
            )

  10.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(400),
    )
  end
end

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

40.times do
  project = Project.all.sample

  Pledge.create!(
    user: User.all.sample,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(1000)
  )
end

60.times do
  owner_update = OwnerUpdate.create!(
              project_update: Faker::Lorem.paragraph(2),
              project_id: rand(1...20),
              user_id: rand(1..5),
              created_at: Time.now.utc - rand(60).days,
              updated_at: Time.now.utc - rand(60).days,
            )
end


120.times do
  comments = Comment.create!(
              comment: Faker::Lorem.paragraph,
              project_id: rand(1...20),
              user_id: rand(1..5),
              created_at: Time.now.utc - rand(60).days,
              updated_at: Time.now.utc - rand(60).days,
            )
end
