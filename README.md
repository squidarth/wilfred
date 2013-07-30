wilfred
=======

Wilfred is a way to validate commits before deploying

TODOS:
====
- Settings for notifications
- Guide for deployments
- Tests
- Add License

Installation and Setup
====
wilfred is a Ruby on Rails application, so to run it locally, you will need to install Ruby on Rails.  Wilfred is pretty 
straightforward to deploy on Heroku.  Look over the docs as to how to deploy a Rails app on Heroku.  You will also need to 
register an application on GitHub (authorization in wilfred works through GitHub.  There are three 
environment variables that must be set in order for the app to work.  These are as follows:

- GH_APP_ID (the id of your GitHub application)
- GH_APP_SECRET (the secret of your GitHub application)
- GH_ORGANIZATION (the organization in which your users must belong)
- GH_REPO (the repository that you are following)
- HIPCHAT_TOKEN (your hipchat token,optional)
- HIPCHAT_ROOM (your hipchat room)
- HIPCHAT_COLOR (the color you'd like hipchat messages to show up in , default is green)
If you would like to specify which branches you would like commits to show up from, feel free to configure them in a file called valid_branches.yml

