Category.create!(name: 'IT')
Category.create!(name: 'Sport')

# Category Art with 2 tests with questions and answers
c1 = Category.create!(name: 'Art')

t1 = Test.create!(title: 'Painters', category_id: c1.id, level: 1)
q1 = Question.create!(
  body: 'the Madonna Enthroned was painted by which Italian artist?',
  test_id: t1.id
)
Answer.create!(body: 'Michelangelo', question_id: q1.id)
Answer.create!(body: 'Leonardo da Vinchi', question_id: q1.id)
Answer.create!(body: 'Giotto', correct: true, question_id: q1.id)

q2 = Question.create!(
  body: "Norwegian artist Edvard Munch's most famous painting?",
  test_id: t1.id
)
Answer.create!(body: 'The Horror', question_id: q2.id)
Answer.create!(body: 'The Ghost', question_id: q2.id)
Answer.create!(body: 'The Scream', correct: true, question_id: q2.id)

t2 = Test.create!(title: 'Musicians', category_id: c1.id)
q1 = Question.create!(body: 'What was Elton John’s middle name?', test_id: t2.id)

Answer.create!(body: 'Hector', question_id: q1.id)
Answer.create!(body: 'Herman', question_id: q1.id)
Answer.create!(body: 'Hercules', correct: true, question_id: q1.id)

q2 = Question.create!(body: 'What was Bob Dylan’s birth name?', test_id: t2.id)

Answer.create!(body: 'Dylan Thomas', question_id: q2.id)
Answer.create!(body: 'Marshal Dillon', question_id: q2.id)
Answer.create!(body: 'Robert Zimmerman', correct: true, question_id: q2.id)

# User seed
User.create!(name: 'Veronika')
User.create!(name: 'Victoria')