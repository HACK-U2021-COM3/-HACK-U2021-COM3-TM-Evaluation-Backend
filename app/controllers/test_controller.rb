class TestController < ApplicationController
  def index
    render json: { name: 'testUser' }
  end
end
