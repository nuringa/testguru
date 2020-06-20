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

    last_award_date = user_badge_awards('level', level).order(created_at: :desc).first&.created_at

    user_level_tests = if last_award_date.present?
                         user_successfull_tests.where(level: level)
                                               .merge(TestPassage.where("test_passages.created_at > ?", last_award_date ))
                       else
                         user_successfull_tests.where(level: level)
                       end

    user_level_tests.distinct.count == Test.where(level: level).count
  end

  def category(category)
    return unless @test_passage.successful? && category == @test.category.name
    
    last_award_date = user_badge_awards('category', category).order(created_at: :desc).first&.created_at

    user_level_tests = if last_award_date.present?
                         user_successfull_tests.where(category_id: @test.category.id)
                                               .merge(TestPassage.where("test_passages.created_at > ?", last_award_date ))
                       else
                         user_successfull_tests.where(category_id: @test.category.id)
                       end

    user_level_tests.distinct.count == Test.where(category_id: @test.category.id).count
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

  def user_badge_awards(rule_name, rule_value)
    @user.badges_users.where(badge: Badge.where(rule_name: rule_name, rule_value: rule_value))
  end
end
