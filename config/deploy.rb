set :application, "gogolf" # Your application location on your server goes here

default_run_options[:pty] = true

set :repository,  "."
set :scm, :none
set :deploy_via, :copy

set :checkout, 'export'

set :user, 'gogolf' # Your username goes here
set :use_sudo, false
set :domain, 'gogolf.fi' # Your domain goes here
set :applicationdir, "/home/#{user}/#{application}"
set :deploy_to, applicationdir

role :web, "ssh.sjr.fi"                 
role :app, "ssh.sjr.fi"                          
role :db,  "ssh.sjr.fi", :primary => true 


set :chmod755, "app config db lib public vendor script script/* public/disp*"

namespace :deploy do
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
end