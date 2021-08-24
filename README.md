# README

Welcome to my training TWITTERLIKE APP. I've done it in education purpose and 
it would be great it you leave some code review or any feedback to me. 

what's been covered:
* sign_in/sign_up/recover_password (devise)
* JWT tokens (devise-jwt)
* worker (Sidekiq, Sidekiq-Scheduler)
* emails (gmail smtp)
* db (postgresql)
* MVC (User, Micropost, Relationship: followed, following)
* some specs (Rspec, FactoryBot, Faker)
* pictures attachment (Amazon S3)
* gravatar
* deployed on heroku US severs
* pagination (kaminari)
* authorization (pundit)
* QueryObject pattern (look at API)
* some APIs (below)

Some APIs:
* `POST` to `/api/v1/users` -- registration
* `POST` to `/api/v1/users/sign_in` -- sign in
* `GET`  to `/api/v1/microposts` -- shows all user's microposts
* `GET`  to `/api/v1/microposts_search` -- shows user's microposts by query parameter

how to:
* open https://twitterlike-prod.herokuapp.com/
* sign up (email could be in spam -- free smtp service issues)
* write something in microblog
* open Users and follow anyone you insterested for

Thank you and welcome to my github!
