require 'test_helper'

class CitaControllerTest < ActionController::TestCase
  test "should get ver_citas" do
    get :ver_citas
    assert_response :success
  end

end
