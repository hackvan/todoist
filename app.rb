require 'sinatra'
require 'make_todo'

set :sessions, true

get '/' do
  redirect '/tasks'
end

get '/tasks/?' do
  @title = "Home"
  @task  = Tarea.all
  @task.sort!{ |a, b| b["created_at"] <=> a["created_at"] }
  @flash = session[:flash]
  session[:flash] = nil
  erb :index
end

post '/task/new' do
  Tarea.create(params[:task])
  session[:flash] = {
    message: "The task has been created",
    type: "success"
  }
  redirect '/tasks'
end

patch '/task/:id/done' do
  Tarea.update(params[:id].to_i)
  redirect '/tasks'
end

delete '/task/:id/delete' do
  Tarea.destroy(params[:id].to_i)
  session[:flash] = {
    message: "The task has been deleted",
    type: "info"
  }
  redirect '/tasks'
end
