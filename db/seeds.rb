# uncomment if data erase is needed
# Answer.delete_all
# Question.delete_all
# Test.delete_all
# User.delete_all
# TestsUser.delete_all
# Category.delete_all

categories = Category.create!([{ name: 'IT' }, { name: 'Sport' }, { name: 'Art'}])

users = User.create!([{ name: 'Veronika' }, { name: 'Victoria' }])

tests = Test.create!([{ title: 'Painters', category: categories[2], level: 1, author: users[1] },
                      { title: 'Musicians', category: categories[2], author: users[0] }])

questions = Question.create!([
  { body: 'the Madonna Enthroned was painted by which Italian artist?', test: tests[0] },
  { body: "Norwegian artist Edvard Munch's most famous painting?", test: tests[0] },
  { body: 'What was Elton John’s middle name?', test: tests[1] }
                            ])

answers = Answer.create!([{ body: 'Michelangelo', question: questions[0] },
                          { body: 'Leonardo da Vinchi', question: questions[0] },
                          { body: 'Giotto', correct: true, question: questions[0] },
                          { body: 'The Horror', question: questions[1] },
                          { body: 'The Ghost', question: questions[1] },
                          { body: 'Giotto', correct: true, question: questions[1] },
                          { body: 'Hector', question: questions[2] },
                          { body: 'Herman', question: questions[2] },
                          { body: 'Hercules', correct: true, question: questions[2] }])

tests_users = TestsUser.create!([{ test: tests[0], user: users[0] },
                                 { test: tests[1], user: users[1] },
                                 { test: tests[0], user: users[1] }])
