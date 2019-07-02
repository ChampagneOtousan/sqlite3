require "sinatra"
require "sqlite3"

$db = SQLite3::Database.new("./database.sqlite3")

$db.execute("create table users(email varchar(255), password varchar(255), PRIMARY KEY (id));")

class User
  attr_accessor :email, :password
  def initialize(email, password)
    @email = email
    @passowrd = password
  end

  def valid?
    if (@email != "" && @password != "" && @password.length > 7)
      return true
    end

    def self.all
      @all = $db.execute("SELECT * FROM users;")
      return @all
    end

    def self.find(id)
      @user = $db.execute("SELECT * FROM users WHERE id = '#{id}';")
      return @user
    end

  end

  def save
    $db.execute("INSERT INTO users(email, password) VALUES ('#{@email}', '#{@passowrd}');")
    return true
  end
end

get "/" do
  erb :home
end

get "/signup" do
    erb :signup
end

get "/users" do

end

post "/signup" do
  p "POST request received"
  p params
  @user = User.new(params['email'], params['password'])
  if @user.valid?
    @user.save
    redirect "/thank-you", 301
  end
end

get "/thank-you" do
  erb :thanks
end
