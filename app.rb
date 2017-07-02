require 'sinatra'
require 'make_todo'

get '/' do
  @title = "Home"
  @task  = Tarea.all
  erb :index
end
