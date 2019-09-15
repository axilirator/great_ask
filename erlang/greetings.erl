-module(greetings).
-export([start/1, handle_msg/1, say_hello/2]).

%% Basic functionality, to be "inherited"
say_hello(HelloStr, Name) ->
	io_lib:format("~s, ~s!", [HelloStr, Name]).

%% Generic process handling code
start(HelloStr) ->
	spawn(?MODULE, handle_msg, [HelloStr]).

handle_msg(HelloStr) ->
	receive
		{say_hello, From, {Name}} ->
			Response = say_hello(HelloStr, Name),
			From ! {hello, self(), {Response}};
		{Message, From, Params} ->
			From ! {unhandled, self(), {Message, Params}}
	end,
	%% Keep going
	handle_msg(HelloStr).
