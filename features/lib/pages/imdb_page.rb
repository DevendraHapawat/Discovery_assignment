class ImdbPage
  SIGN_IN_BTN = '//div[text()="Sign In"]'
  CREATE_NEW_ACCOUNT_BTN = '//a[text()="Create a New Account"]'
  YOUR_NAME_INPUT = "input[name='customerName']"
  EMAIL_INPUT = '#ap_email'
  PASSWORD_INPUT = '#ap_password'
  PASSWORD_RECHECK_INPUT= '#ap_password_check'
  CREATE_IMDB_ACCOUNT_BTN = "#continue"
  SIGN_IN_WITH_IMDB = "//span[text()='Sign in with IMDb']/parent::a"
  LOGIN_BTN = "#signInSubmit"

  class << self
    # function to navigate on home page.
    def navigate_to_home
      visit '/'
      page.driver.browser.manage.window.maximize
    end

    # function to create new imdb account
    def create_new_imdb_account
      CommonHelper.wait_for_element_to_present(SIGN_IN_BTN, :xpath)
      page.find(:xpath,SIGN_IN_BTN).click
      CommonHelper.wait_for_element_to_present(CREATE_NEW_ACCOUNT_BTN, :xpath)
      page.find(:xpath,CREATE_NEW_ACCOUNT_BTN).click
      user_name = "QA#{Time.now.to_i}"
      CommonHelper.wait_for_element_to_present(YOUR_NAME_INPUT)
      page.find(YOUR_NAME_INPUT).set user_name
      page.find(EMAIL_INPUT).set "#{user_name}@gmail.com"
      page.find(PASSWORD_INPUT).set "Pass_#{user_name}"
      page.find(PASSWORD_RECHECK_INPUT).set "Pass_#{user_name}"
      page.find(CREATE_IMDB_ACCOUNT_BTN).click
      user_name
    end

    def sign_in(user_name)
        ImdbPage.navigate_to_home
        CommonHelper.wait_for_element_to_present(SIGN_IN_BTN, :xpath)
        page.find(:xpath,SIGN_IN_BTN).click
        CommonHelper.wait_for_element_to_present(SIGN_IN_WITH_IMDB, :xpath)
        page.find(:xpath,SIGN_IN_WITH_IMDB).click
        binding.pry
        CommonHelper.wait_for_element_to_present(EMAIL_INPUT, :xpath)
        page.find(EMAIL_INPUT).set "#{user_name}@gmail.com"
        page.find(PASSWORD_INPUT).set "Pass_#{user_name}"
        page.find(LOGIN_BTN).click
    end
  end
end