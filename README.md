# Instchat
##### System dependencies
1. Ruby version 2.3.8
1. Rails 5.2
1. elasticsearch 6.6.2
1. redis 3.2.3
1. mysql 5.7
1. docker version 17.05.0
1. docker-compose version 1.8.1
##### Database creation

`rails db/setup`
##### Services

1. sidekiq
##### Start the app
`docker build -t instchat .`
`docker-compose build`
`docker-compose up`
after the app starts initialize the db
`docker-compose run app rails db:setup`
`docker-compose run app rails searchkick:reindex:all`

 ##### Design
The App is designed with 3 tables: Apps, Chats and messages.
Apps:
- had a requirement to use unique tokens as the app ID so it uses has_secure_token to generate the id and not the db's autoincrment integer
- uses a counter_cache for storing current chat apps belonging to this app.

Chats:
- a requirement was to have the ability of having all chats belonging to any app to start counting IDs from 1, so we can have 2 chats with ID 1 but their app_id is different, to achieve this, composite_primary_keys gem was used, now the primary key is id -auto increment by the db- and app_id as foreign_key. this way, 2 chats can have ID of 1 but different apps, the second problem was not to relly on the DB counter for incrementing the chat id, since the ID will keep track only to latest ID used so if the latest chat added had ID 10 then the counter for next chat will be 11 even if it's not in the same app, for this the ID of the chat is set in a before_create observer by fetching the count of chats on the app and adding 1.

messages:
- messages had the same requirement to be able to count starting 1 for each chat on an app, composite primary key was used again but this time, its a ID, chat_id and app_id. which added some complexity in rails migrations and model to model relation so the fk constraint wasn't added thru db level instead from app level in rails.
- adding this caused the counter_cache for chat not to work properly so it had to be incremented manually.
- messages uses elasticsearch to fetch and search in messages of a given app using searchkick, but it doesnt load the message object since most elasticsearch gems do not work properly with composite primary keys, it considers the ID as a string of the 3 IDs concatenated by comma, e.g. 'id,chat_id,app_id'='1,1,90nkfndsiu' so when loading it from active record, it doesn't insert the attribute name nor the value properly.
- to avoid writing the messages during the API request sidekiq was used as background job, a job is started with the boot of the system that listens on a redis key using the blocking redis command lpop, the job stays blocked till the create API pushes the params as json to the key, once pushed the background job creates the actual message and registers the job again. This way the writing is avoided during the API call since writes in this RDMS can be expensive for chatting apps.


##### Using the app:

using `docker ps` get the port used for the app
list apps `curl http://localhost:{PORT}/v1/apps/`
create app `curl -X POST http://localhost:{PORT}/v1/apps/ -d name='first'`
list chats of an app `curl http://localhost:{PORT}/v1/apps/{ID}/chats`
create chat for an app `curl -X POST http://localhost:{PORT}/v1/apps/{ID}/chats`
list messages for a given chat on app `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages`
search messages for a given chat on app `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages?keyword='hello world'`
create message for a given chat `curl http://localhost:{PORT}/v1/apps/{ID}/chats/{ID}/messages -d body='hello world'`
