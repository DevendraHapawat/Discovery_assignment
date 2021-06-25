Given("I visit IMDB's site") do
  ImdbPage.navigate_to_home
end

And('I create a new account on IMDB') do
  @user_name = ImdbPage.create_new_imdb_account
end

And('I login to IMDB with newly created credentials') do
   ImdbPage.sign_in(@user_name)
end
