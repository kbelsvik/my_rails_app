require 'spec_helper'

RSpec.describe GreetingsController, type: :controller do
  it 'should get hello' do
    get :hello
    assert_response :success
  end

  it 'should fail', :fail => true do
    fail
  end
end
