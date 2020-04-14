class TestsController < ApplicationController
  def index
    render inline: 'All tests'
  end
end
