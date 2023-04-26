5.times do
  article = Article.create(
    {
      title: Faker::Book.title,
      body: Faker::Lorem.sentence,
      release_date: Faker::Date.between(from: Date.today, to: 30.days.from_now())
    }
  )
end
