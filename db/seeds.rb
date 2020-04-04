categories = Category.create!([{ name: 'IT' }, { name: 'Sport' }, { name: 'Art'}])

tests = Test.create!([{ title: 'Painters', category_id: categories[2].id, level: 1 },
                      { title: 'Musicians', category_id: categories[2].id }])

questions = Question.create!([
  { body: 'the Madonna Enthroned was painted by which Italian artist?', test_id: tests[0].id },
  { body: "Norwegian artist Edvard Munch's most famous painting?", test_id: tests[0].id },
  { body: 'What was Elton John’s middle name?', test_id: tests[1].id }
                            ])

answers = Answer.create!([{ body: 'Michelangelo', question_id: questions[0].id },
                          { body: 'Leonardo da Vinchi', question_id: questions[0].id },
                          { body: 'Giotto', correct: true, question_id: questions[0].id },
                          { body: 'The Horror', question_id: questions[1].id },
                          { body: 'The Ghost', question_id: questions[1].id },
                          { body: 'Giotto', correct: true, question_id: questions[1].id },
                          { body: 'Hector', question_id: questions[2].id },
                          { body: 'Herman', question_id: questions[2].id },
                          { body: 'Hercules', correct: true, question_id: questions[2].id }])

users = User.create!([{ name: 'Veronika' }, { name: 'Victoria'} ])

tests_users = TestsUser.create!([{ test_id: tests[0].id, user_id: users[0].id },
                                 { test_id: tests[1].id, user_id: users[1].id },
                                 { test_id: tests[0].id, user_id: users[1].id }])

