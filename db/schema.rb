ActiveRecord::Schema.define(version: 2020_04_02_094021) do

  enable_extension 'plpgsql'

  create_table 'answers', force: :cascade do |t|
    t.string 'body', null: false
    t.boolean 'correct', default: false
    t.bigint 'question_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'body', null: false
    t.bigint 'test_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['test_id'], name: 'index_questions_on_test_id'
  end

  create_table 'tests', force: :cascade do |t|
    t.string 'title', null: false
    t.integer 'level', default: 0
    t.bigint 'category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['category_id'], name: 'index_tests_on_category_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'answers', 'questions'
  add_foreign_key 'questions', 'tests'
  add_foreign_key 'tests', 'categories'
end
