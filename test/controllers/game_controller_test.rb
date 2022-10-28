# frozen_string_literal: true

require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test 'should get guess' do
    get game_guess_url
    assert_response :success
  end
end
