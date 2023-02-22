module AuthorizationHelper
  def sign_in(user)
    post "/api/v1/auth/sign_in", params: { email: user.email, password: user.password }
    response.headers.slice("access-token", "client", "uid")
  end
end
