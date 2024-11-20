require 'sqlite3'
require 'active_record'
require_relative '../models/task'

# Establish the connection to the database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/tasks.db'
)

begin
  ActiveRecord::Schema.define do
    # Drop the tasks table if it exists
    if table_exists?(:tasks)
      drop_table :tasks
    end

    # Create the tasks table with auto-incrementing primary key
    create_table :tasks do |t|
      t.string :description
      t.boolean :done, default: false
      t.timestamps
    end
  end
  puts "Table 'tasks' created successfully."

  # Populate the table with initial data
  tasks = [
    { description: 'Buy groceries', done: false },
    { description: 'Read a book', done: false },
    { description: 'Go for a run', done: true }
  ]

  tasks.each do |task_data|
    task = Task.new(task_data)
    if task.save
      puts "Task '#{task.description}' created successfully."
    else
      puts "Failed to create task: #{task.errors.full_messages.join(', ')}"
    end
  end
  puts "Database setup complete with sample data."
rescue => e
  puts "An error occurred: #{e.message}"
  puts e.backtrace
end

# Verify table creation and data insertion
begin
  Task.all.each do |task|
    puts "Task ID: #{task.id}, Description: #{task.description}, Done: #{task.done}, Created At: #{task.created_at}"
  end
rescue => e
  puts "An error occurred when verifying data: #{e.message}"
  puts e.backtrace
end