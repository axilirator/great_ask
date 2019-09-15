#!/usr/bin/env escript

flush_msg() ->
	receive
		{unhandled, _From, {Message, Params}} ->
			io:format("Unhandled message ~p with params ~p~n", [Message, Params]);
		{_Message, _From, {Response}} ->
			io:format("~s~n", [Response])
	end.

main(_) ->
	AskDeProc = questions:start("Mahlzeit"),
	AskEnProc = questions:start("Hello"),

	%% Check the "inherited" functionality
	AskDeProc ! {say_hello, self(), {"Max"}}, flush_msg(),
	AskEnProc ! {say_hello, self(), {"Max"}}, flush_msg(),

	%% Check the new functionality
	AskDeProc ! {ask_question, self(), {"Max", "Wie geht's"}}, flush_msg(),
	AskEnProc ! {ask_question, self(), {"Max", "How are you"}}, flush_msg(),

	ok.
