class Admin::TestsController < Admin::BaseController

  before_action :find_test, only: %i[show edit update destroy start]

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = current_user.author_tests.build(test_params)

    if @test.save
      redirect_to [:admin, @test], notice: 'Test was successfully created'
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test], notice: 'Test was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_tests_path, alert: 'Test was destroyed' if @test.destroy
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:level, :title, :category_id)
  end
end
