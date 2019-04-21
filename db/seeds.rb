# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
App.create(name: 'Lord of the Rings')
Chat.create(app: App.first)
Message.create(body: 'Hi Gandalf', chat: Chat.first)
Message.create(body: 'Hey Sam', chat: Chat.first)
Chat.create(app: App.first)
Message.create(body: 'Hola Bilbo', chat: Chat.last)
Message.create(body: 'Aloha Frodo', chat: Chat.last)


App.create(name: 'Starwars')
Chat.create(app: App.last)
Message.create(body: 'Hi Skywalker', chat: App.last.chats.first)
Message.create(body: 'Hey obi-wan', chat: App.last.chats.first)
Chat.create(app: App.last)
Message.create(body: 'Greetings DarthVader', chat: App.last.chats.last)
Message.create(body: 'Howdy Senator Palpatin', chat: App.second.chats.last)
