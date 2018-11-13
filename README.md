# README

Sample project written for a job application.

See [doc](doc/Case%20study(6h)_%20Identifier(token)%20generator.pdf) for the task description.

Authentication was implemented using omniauth and github oauth2.
This requires to provide an application id and secret through the
environment variables `GITHUB_KEY` and `GITHUB_SECRET`.
Alternatively authentication can be turned off by setting the environment
variable `SKIP_AUTHENTICATION` to anything.

Data can be filled with random data using the `db:populate` rake task.
A `SIZE` parameter defines the number of records per table (default 100).
Multiple calls add up.
Data can be removed using `db:clean`.

## Setup (for local development)

 * create a xbav user in the database
 * user must have rights to create databases or you have to create
   the databases `xbav_sample_app_development` and `xbav_sample_app_test`
 * run `rake db:setup` or `rake db:migrate` / `rake db:schema:load` to
   setup the database; same for test env
 * run the rails server
