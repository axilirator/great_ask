-module(questions).
-export([start/1, handle_msg/2, ask_question/3]).

%% This function is based on "inherited" functionality
ask_question(HelloStr, Name, Question) ->
	Hello = greetings:say_hello(HelloStr, Name),
	io_lib:format("~s ~s?", [Hello, Question]).

%% Generic process handling code
start(HelloStr) ->
	Great = greetings:start(HelloStr), link(Great),
	spawn(?MODULE, handle_msg, [Great, HelloStr]).

handle_msg(Great, HelloStr) ->
	receive
		{ask_question, From, {Name, Question}} ->
			Response = ask_question(HelloStr, Name, Question),
			From ! {question, self(), {Response}};
		%% Forward all unknown messages to Great
		{ReqMsg, From, ReqParams} ->
			%% FIXME: this is a blocking operation because
			%% we have to wait for the response from A, and
			%% cannot process other messages...
			Great ! {ReqMsg, self(), ReqParams},
			receive
				{RspMsg, Great, RspParams} ->
					From ! {RspMsg, self(), RspParams}
			end
	end,
	%% Keep going
	handle_msg(Great, HelloStr).
