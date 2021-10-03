# README

Contact importer through csv files

To run this project you only need to follow the next steps:

1. rails db:create db:migrate
2. rails s

You can run the test with the 'rspec' comand

Development environment runs the background jobs with the default queue adapter (not sidekiq) and local disk storage

Droduction environment uses sidekiq and an S3 bucket, you can test the app with the following data:
* url: https://contact-importer-21.herokuapp.com/
* email: user@example.com
* password: password