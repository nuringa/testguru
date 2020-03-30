# TestGuru

приложение на Ruby on Rails в рамках курса от thinknetica

**_Список примерных моделей для TestGuru:_**

1. User(name, email, password, admin)
2. Test(name, category, questions)
3. Question(name, body, answers, test_id)
4. Answer(name, body, correct_answer, question_id)
4. TestProcess(user_id, test_id, time, result)