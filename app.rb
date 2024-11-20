# app.rb
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'tasks_repo'

set :tasks_repo, TasksRepo.new

configure :development do
  register Sinatra::Reloader
  also_reload '**/*.rb'
end


get '/' do
  @tasks = settings.tasks_repo.all
  erb :index
end

post '/tasks' do
  settings.tasks_repo.add(params[:task])
  @tasks = settings.tasks_repo.all
  erb :_task_list, layout: false
end

patch '/tasks/:id' do
  task = settings.tasks_repo.update(params[:id].to_i, done: params[:done] == 'true')
  erb :_task, layout: false, locals: { task: task }
end

delete '/tasks/:id' do
  settings.tasks_repo.delete(params[:id].to_i)
  status 204
end

configure do
  set :port, 4567
  set :bind, '0.0.0.0'
end