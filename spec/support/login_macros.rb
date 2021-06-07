module LoginMacros
  def user_login(user = User.create!(email: 'jane.doe@codeplay.com', password: '123456'))
    login_as user, scope: :user
    user
  end
end
