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


# Requests examples and given returns
1. When user passes correct parameters when creating an user:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/user%20201.png)
2. When user passes incorrect parameters when creating an user:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/user%20null.png)
3. When user passes correct parameters when following another user:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/follow%20201.png)
4. When user passes identical ids when following another user:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/follow%20id%20identical.png)
5. When user passes invalid ids when following another user:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/follow%20404%20valid%20id.png)
6. When user passes correct parameters when creating a tweet:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/tweet%20201.png)
7. When user passes incorrect parameters when creating a tweet:
![](https://github.com/Odoia/tweet-api/blob/development/project_images/tweet%20error%20user%20dont%20exist.png)
# TODO list (improvements for the future):

* Add a autentication user.

