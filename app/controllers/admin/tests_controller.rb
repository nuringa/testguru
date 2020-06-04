class Admin::TestsController < Admin::BaseController

  before_action :find_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update destroy start update_inline]

  def index; end

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
      flash[:success] = t('.success')
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      flash[:success] = t('.success')
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    flash[:danger] = t('.destroyed')
    redirect_to admin_tests_path if @test.destroy
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def find_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:level, :title, :category_id)
  end
end
