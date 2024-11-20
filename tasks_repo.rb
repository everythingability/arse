# tasks_repo.rb
require_relative 'models/task'

class TasksRepo
  def initialize
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/tasks.db'
    )
  end

  def all
    puts Task.all
    Task.all
  end

  def add(description)
    Task.create(description: description)
  end

  def update(id, attributes)
    task = Task.find(id)
    task.update(attributes)
    task
  end

  def delete(id)
    Task.find(id).destroy
  end
end