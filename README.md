# Instchat
##### System dependencies
1. Ruby version 2.3.8
1. Rails 5.2
1. elasticsearch 6.6.2
1. redis 3.2.3
1. mysql 5.7
1. Mongo 4.0
1. docker version 17.05.0
1. docker-compose version 1.8.1
##### Database creation

`rails db/setup`
##### Services

1. sidekiq
##### Start the app
- `docker build -t instchat .`
- `docker-compose build`
- `docker-compose up`

- after the app starts initialize the db
- `docker-compose run app rails db:setup`
- `docker-compose run app rails searchkick:reindex:all`

- to run test coverage
- `docker-compose run app rails test test:controllers`
- `docker-compose run app rails test test/workers/message_write_worker_test.rb`

 ##### Design
The App is designed with 3 tables: Apps, Chats and messages.
Apps:
- had a requirement to use unique tokens as the app ID so it uses has_secure_token to generate the id and not the db's autoincrment integer
- uses a counter_cache for storing current chat apps belonging to this app.

Chats:
- a requirement was to have the ability of having all chats belonging to any app to start counting IDs from 1, so we can have 2 chats with ID 1 but their app_id is different, to achieve this, the primary key was left as it is, another key was created and indexed called (cid) that gets it's value before saving a new chat record, it's value = count of chats on the application + 1.

messages:
- messages had the same requirement to be able to count starting 1 for each chat on an app, another key was created (mid), it's value = count of messages for this chat + 1, the only foreign key is to chat table.

- messages uses elasticsearch to fetch and search in messages of a given app using searchkick

- to avoid persisting the messages during the API request directly to mysql which would cause delays, mongodb was used for persisting the message, a cron job works in the background to persist the message to mysql. after creating the mongodb document the message is broadcasted to it's respective channel.
- When the message is persisted to mongodb, a flag written = false is created for each message, the cron job logic is to fetch messages that still have written = false, write the messages that satisfy this criteria then mark all these objects as written true to flag that it was moved to mysql.

- Action Cable is used to broadcast a message to all the subscribers.

Message Writing operation:
 ![logo](https://github.com/kmhosny/instchat/blob/master/instchat.png)

##### Using the app:

- using `docker ps` get the port used for the app
- list apps `curl http://localhost:{PORT}/v1/apps/`
- create app `curl -X POST http://localhost:{PORT}/v1/apps/ -d name='first'`
- list chats of an app `curl http://localhost:{PORT}/v1/apps/{ID}/chats`
- create chat for an app `curl -X POST http://localhost:{PORT}/v1/apps/{ID}/chats`
- list messages for a given chat on app `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages`
- search messages for a given chat on app `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages?keyword='hello world'`
- create message for a given chat `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages -d body='hello world'`
