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

  def first_try(rule_value)
    return unless @test_passage.successful?

    user_successfull_tests.where(id: @test.id).count == 1
  end

  def level(level)
    return unless @test_passage.successful?
    #TODO
    user_successfull_tests.where(level: level)
  end

  def category(category)

  end

  def loser(rule)

  end

  def user_successfull_tests
    @user.tests.merge(TestPassage.where(success: true))
  end
end
