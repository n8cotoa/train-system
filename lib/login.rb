class Login
  def initialize(attr)
    @email = attr[:email]
    @password = attr[:password]
  end

  def login?
    db_user = DB.exec("SELECT * FROM administrators;")
    user_email = db_user.first["email"]
    user_password = db_user.first["password"]

    if user_email == @email && user_password == @password
      true
    else
      false
    end
  end
end
