require "test_helper"

class HomepagePlainTest < Capybara::Rails::TestCase
   test "welcome message is visible" do
     visit root_path

     assert_content page, "Welcome"
   end
end
