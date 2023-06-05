class UserLogsPresenter

def initialize(user)
  @user = user
end

def count_logs
  user_logs.count
end

def user_logs
  @user_logs ||= UserLogsApiConnector.new.user_logs(@user)
end

end
