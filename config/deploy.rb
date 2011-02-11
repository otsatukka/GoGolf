set :application, "gogolf"
set :repository,  "git@github.com:gogolf/GoGolf.git"
set :deploy_to, "/public_html/gogolf"
set :user, "gogolf"
set :scm_passphrase, "TY3pDOvd"
set :branch, "master"
set :git_enable_submodules, 1
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.gogolf.fi"                          # Your HTTP server, Apache/etc
role :app, "www.gogolf.fi"                          # This may be the same as your `Web` server
role :db,  "sql.sjr.fi", :primary => true # This is where Rails migrations will run
role :db,  "sql.sjr.fi"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end