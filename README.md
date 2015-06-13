My general approach was to have a view of the big picture and start carving a design from there.

That big picture can be seen in commit [610a88d](https://github.com/kartesus/fyber-challenge/commit/610a88dbd1f6b19340620286c832680b41a429c5). Looking at this script I tried to understand where side effects are necessary and try to separate that code from code that can be tested in isolation.

For most part of the development I have then 2 testing cycles. When extracting a class I focus only on the unit tests run via rspec. When I'm satisfied with that I have to update my script to use the new class and everything should work.

When what was left in the script was only I/O and orchestration of the business objects I extracted that to it's own object. I tend not to right a lot of functional tests. Instead of that in a production application I would put extra effort in error handling and monitoring.

In the end I just wrapped the service in a sinatra application without put an effort in making a good UI because at this point the challenge is solved. Being served by sinatra, padrino, rails, webrick, puma are details, as is the UI, and can be easily changed.
