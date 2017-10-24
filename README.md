<h1>Events have a :title, (not a name)</h1>

<h2>Shortcuts to access elements of EVENTS:</h2>
<h4>All players in an event</h4>
```
@event.players.each do |player_instance|
  user_instance = player_instance.user
  <p><%= user_instance.username %> ||| <%= user_instance.level %></p>
  #=>'noob_slayer69 ||| 15.666667'
end
```
Player instances are NOT USER INSTANCES!!!!
You have to call
```
.user
```
on a player instance to retrieve the user profile, and from there you can access other information such as email/username/level/coins/etc....
<h2>Shortcuts to access elements of USERS:</h2>
<h4>All events hosted by a particular user</h4>
```
@user.host.events
#=>[ ... ]
#(... are event instances)
```
You can chain event shortcuts on top of these to have something as complex as:
```
@user.host.events[0].players[3].user.host.events.each do |a_users_event|
  puts a_users_event.title
  puts a_users_event.game.name
end
```
The above command will get the first event hosted from the specified user(.host.events[0]) and get the 4th player from that event (.players[3] -- remember indexes start at 0) and iterate over their events (.user.host.each do |a_users_event|)
```
# Reminder, you can only access a user's host info, NOT a player's host info. You can access a player's host info from their USER info
```
and lastyl you can access individual details from that event such as the title of it (event.title) and the game name

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
