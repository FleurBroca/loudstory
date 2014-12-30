# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Track.destroy_all
Exercise.destroy_all
Session.destroy_all

track = Track.create!(
  { title: 'Your Shining Star Story', description: 'Being unique is the price to pay to tell good stories.The stories you tell are what you are made of (cf your story, your aspirations, your fears, your passion, your intelligence, your vision). That’s what you ought to share. Inspire people like you’ve been inspired in your life. Care for people. Wish them the best for their lives. Do it for them. Do things for them. You love people when they care for you. You love even more people when they inspire you to be your best, when you’re thinking: « what is he going to do next? »
There is a certain value in not bragging about it. Our times are all about « show them who you are, tell them to share your posts, like your page, tweet your fabulous thoughts. But there is a certain value in modesty, in stepping back and putting them first.
Inspire them with what you believe in and what you know to be your best self, wether by being provocative, imaginative, funny or true.', position: 1 }
  )

exercise1 = track.exercises.create!(
  {
    title: "The hero's avatar",
    description: "To speak to people's heart and find the tension that will set the story in motion, you have to validate your audience's fears, and recognize they have the potential to become a hero",
    position: 1
  })

exercise1.questions.create!([
  { title: "Are you a woman or a man?",
    description: "To speak to people's heart and find the tension that will set the story in motion, you have to validate your audience's fears, and recognize they have the potential to become a hero",
    position: 1
  },
  { title: "How does your friends call you?", description: "seed", position: 2 },
  { title: "If you don't mind me asking... how old are you?", description: "seed", position: 3 },
  { title: "Do you have a significant other?", description: "seed", position: 4 },
  { title: "Where do you work?", description: "seed", position: 5 },
  { title: "What inspired you to go into that?", description: "seed", position: 6 }
  ])

exercise2 = track.exercises.create!(
  {
    title: "The hero's fears and dreams",
    description: "In this 2nd exercise, we want to understand the hopes and dreams of our core user. What he aspires to achieve in his life, and why he feels stuck today.",
    position: 2}
)

exercise2.questions.create!([
  { title: "The hero's fears",
    description: "In this letter, the user tells about a recent experience or a conversation he's had, that recalled him about long-time frustrations (regarding the problem we’re trying to solve). He remembers some deep thoughts he has had and  he feels the need to share them with him/her today. ",
    position: 1
  },
  { title: "The hero's dreams",
    description: "Finally, the hero dares speak about his intuition that something more is possible. He is ready for something more real. He still can ignore it. It's up to him to decide whether or not he's set out for the adventure", position: 2 }
  ])