class UserContext
  attr_reader :user, :cookies

  def initialize(user, cookies = nil)
    @user = user
    @cookies = cookies
  end
end
