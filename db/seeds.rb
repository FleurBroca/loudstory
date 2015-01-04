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

track1 = Track.create!(
  { title: 'Your North Star Story', description: 'Being unique is the price to pay to tell good stories.The stories you tell are what you are made of (cf your story, your aspirations, your fears, your passion, your intelligence, your vision). That’s what you ought to share. Inspire people like you’ve been inspired in your life. Care for people. Wish them the best for their lives. Do it for them. Do things for them. You love people when they care for you. You love even more people when they inspire you to be your best, when you’re thinking: « what is he going to do next? »
There is a certain value in not bragging about it. Our times are all about « show them who you are, tell them to share your posts, like your page, tweet your fabulous thoughts. But there is a certain value in modesty, in stepping back and putting them first.
Inspire them with what you believe in and what you know to be your best self, wether by being provocative, imaginative, funny or true.', position: 1 }
  )

exercise1 = track1.exercises.create!(
  {
    title: "The hero's avatar",
    description: "In this first exercise, we want to create an avatar of our primary user. It will help us have a clear sense of who we are talking to as a brand. <br> It's important to realize that a brand is not 'addressing a target': it's talking and interacting with real people, characterized by their own set of feelings, their own personal issues, a professional background, specific needs, cultural references, etc. For that purpose, we will have use our imagination and step into our user's shoes. So, first and foremost, let's choose a person that embodies our core user: it can be a real person we actually know (a friend, a client) or a fictitious character. For each of the 20 following questions, we will pretend we are the customer. Before we start, let’s first pause for 2 minutes and think of who might embody our ideal customer. If our service could be used by different types of users, we should choose the one that’s either: - the easiest to reach at the beginning, - or the largest group of people - which means more opportunities, - or the group of early adopters that will have the biggest influence on future users (think of the aura of startups on big corporations, or the aura of designers on hipsters…). Another thing: when you start answering, don’t be surprise if you feel like you’re giving personal responses, based on your own experience. It’s inevitable when entrepreneurs try to solve a problem they’ve personally experienced. The avatar of user is therefore very close to the personality of the founder. But that’s actually a good thing if it helps you understand your customer more deeply and then forge a more credible mentor.",
    position: 1
  })

exercise1.questions.create!([
  { title: "Are you a woman or a man?",
    description: "Choose one or the other. Preferably",
    position: 1
  },
  { title: "How does your friends call you?", description: "First, last, middle or username", position: 2 },
  { title: "If you don't mind me asking... how old are you?", description: "Just a number", position: 3 },
  { title: "Are you married or do you share your life with someone?", description: "You don't need to expand on that.", position: 4 },
  { title: "What do you do for a living?", description: "Your work or daily activity", position: 5 },
  { title: "What inspired you to go into that?", description: "Share you thoughts in 1 or 2 sentences.", position: 6 }
  ])

exercise2 = track1.exercises.create!(
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

exercise3 = track1.exercises.create!(
  {
    title: "Your pitch",
    description: "In this 2nd exercise, we want to understand the hopes and dreams of our core user. What he aspires to achieve in his life, and why he feels stuck today.",
    position: 3}
)

exercise3.questions.create!([
  { title: "For audience",
    description: "Name your core audience, the true heroes of your story. i.e. airbnb 'For travellers...'",
    position: 1
  },
  { title: "who has hopes/fears",
    description: "Describe the main issue you want to empower your audience on. It can be either a fear, or a hope, or both. i.e. airbnb: '... who hope for a more human experience when they travel, who fear to feel like a stranger...'",
    position: 2
  },
  { title: "brand provides product",
    description: "Name your company and describe the product that you offer... i.e 'airbnb provides marketplace for people to book and list short-term rentals...' ",
    position: 3
  },
  { title: "with mission",
    description: "Use your entrepreneurial dream and your customers' inner truth to define what goal you want to achieve... i.e. airbnb 'unique and inspiring places within a trusted community'",
    position: 4
  },
  { title: "because of proof",
    description: "Define the one thing that is specific about you (your secret sauce or key ingredient) that proves you can achieve this goal. i.e. airbnb: '...an online platform providing free photo service and curation system. ",
    position: 5
  },
  { title: "Compile all elements and edit them until the pitch feels right.",
    description: "i.e. airbnb: 'For people who want a more human experience when they travel, airbnb provides a marketplace to list, discover and book unique and inspiring places within a trusted community, thanks to a free photo service and a curation system.'",
    position: 6
  }])


