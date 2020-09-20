#Tweet Api Project


This API simulates an app like Twitter with four endpoints that allows to create and follow an user, publish a tweet and get a tweet feed with user and followers tweets.
It uses Ruby 2.7.1, Rails 6 and it is needed Postgres 12.

# What do you need to run the project

Clone this project and run those commands in sequence:

* bundle install
* rails db:create
* rails db:migrate
* rails s

# API documentation

[API mind map](http://www.xmind.net/m/sPAuGg)


# Endpoints
## Create an user
* You need to access 'POST: api/v1/user' route passing user information ({"user": {name: "name here"}}). 

## Follow an user
* You need to access 'POST: api/v1/follow' route passing follow relationship ({"follow": {  "userId": 1 , "followUserId": 2  } }). 
* For this endpoint success, you need to pass two valid and different ids.

## Publish a tweet
* You need to access 'POST: api/v1/tweet' route passing user id and tweet message ({"tweet":{"userId": 1 "message": "tweet here" }}). 

## Tweet feed
* You need to access 'GET: api/v1/tweet/{userId}' route passing the id of the current user.
* This endpoint brings a list of tweet message from both the current user and his followers.

# TODO list (improvements for the future):

* Add a autentication user.

