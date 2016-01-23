module SpecTestHelper   

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
  end

end