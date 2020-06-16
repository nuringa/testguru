class Awarder
  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
  end

  def call
    Badge.all.select { |badge| send(badge.rule_name, badge.rule_value) }
  end

  private

  def first_try(_rule_value)
    return unless @test_passage.successful?

    user_successfull_tests.where(id: @test.id).count == 1
  end

  def level(level)
    return unless @test_passage.successful? && level == @test.level.to_s

    level_badges_count = @user.badges.where(rule_name: 'level').count
    user_level_tests = user_successfull_tests.where(level: level)
    level_tests = Test.where(level: level)

    level_tests.select { |test| user_level_tests.where(id: test.id).count > level_badges_count }
               .size == level_tests.size
  end

  def category(category)
    return unless @test_passage.successful? && category == @test.category.name

    category_badges_count = @user.badges.where(rule_name: 'category').count
    user_category_tests = user_successfull_tests.where(category_id: @test.category.id)
    category_tests = Category.find_by(name: category).tests

    category_tests.select { |test| user_category_tests.where(id: test.id).count > category_badges_count }
        .size == category_tests.size
  end

  def loser(_rule_value)
    return if @test_passage.successful?

    loser_badges_count =  @user.badges.where(rule_name: 'loser').count
    user_loser_tests = @user.tests.merge(TestPassage.where.not(success: true))

    Test.all.select { |test| user_loser_tests.where(id: test.id).count > loser_badges_count }
        .size == Test.count
  end

  def user_successfull_tests
    @user.tests.merge(TestPassage.where(success: true))
  end
end
