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
    return if !@test_passage.successful? || @user.badges.find_by(rule_name: 'level', rule_value: level)

    user_successfull_tests.where(level: level).uniq.count == Test.where(level: level).count
  end

  def category(category)
    return if !@test_passage.successful? || @user.badges.find_by(rule_name: 'category', rule_value: category)

    user_successfull_tests.where(category_id: @test.category.id).uniq.count == Test.where(category_id: @test.category.id).count
  end

  def loser(_rule_value)
    return if @test_passage.successful? || @user.badges.find_by(rule_name: 'loser')

    @user.tests.merge(TestPassage.where.not(success: true)).uniq.count == Test.all.count
  end

  def user_successfull_tests
    @user.tests.merge(TestPassage.where(success: true))
  end
end
