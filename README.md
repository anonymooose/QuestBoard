Basic Console commands + erb


```bash
Most tips listed below pertain to @event instances
since they are the core feature of the app
```
Event instances have a title (not a name)
```ruby
@event.name
# => NoMethodError
@event.title
# => 'Carla's event' (string)
```
These EVENT instance methods will return the following ARRAYS:
```ruby
:PLAYERS
# returns relevant player instances
# @event.players.first will be the host's player
@event.players
# => [@player,@player,@player]

:SURVEYS
# will return [] if they are not sent out yet.
@event.surveys
# => []

:SURVEYS!
# will check if event is past ard distributed THEN
# iterate over all players AND
# forcibly distribute surveys if they aren't already. use sparingly
@event.surveys!
# => [@survey,@survey,@survey]
```

Other EVENT instance methods and their return value
```ruby
:HOST
# returns the host profile of event
@event.host
# => @host

:GAME
# game instance
@event.game
# => @game

:PAST?
# simply returns true or false if over
@event.past?
# => true

:WIN
# returns USER INSTANCE (@user) who won if votes are cast
# returns nil unless sufficient votes cast
@event.win
# => @user (id:1,username:'admin'....etc)
```

Will write more later

```html
Rails app generated with
[<a href="https://github.com/lewagon/rails-templates">lewagon/rails-templates</a>]
created by the
[<a href="https://www.lewagon.com">Le Wagon coding bootcamp</a>] team.
```
