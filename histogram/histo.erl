-module(histo).
-export([word_histogram/1]).
-export([word_histogram/2]).

%% words/1
%%
%% Break a string into a list of words.  Syntax here is pretty arcane even by
%% Erlang standards, so breaking it down:
%%
%% re:run/3 will find matches of the regex /2 in the /1 string, using the options
%% specified in /3.  The options list here specifies two things:
%%
%% global - find ALL matches, not just the first
%% {capture,first,list} - return value specification
%%
%%    'capture' indicates that we will be returning the captured pattern 
%%    'first' means that we will return the first capture (there is only one
%%        in this example)
%%    'list' means we will return the capture as a list (other options are 
%%        index tuples and binaries)
%%
%% So... all of this means that we will return a list of lists, with each list
%% containing a single capture of our pattern.
%%
%% '[hd(C) || C<-Captures]' is an Erlang list comprehension, meaning 'for each
%% C in Captures, return the head of the list'.  This will turn the list of lists
%% into a simple list of words.
%%
%% Simple, eh?
%%
words(String) ->
    case re:run(String, "\\w+(\\'\\w+)?", [global,{capture,first,list}]) of
	{match, Captures} -> [string:to_lower(hd(C)) || C<-Captures];
	nomatch -> []
    end.

count_words([],Dict) -> Dict;
count_words([Word|Remainder], Dict) ->
    NewDict = dict:update_counter(Word,1,Dict),
    count_words(Remainder,NewDict).

%% word_histogram/1 (exported)
%%
%% Generates a word histogram from the specified string
%%
word_histogram(String) -> word_histogram(String, dict:new()).

%% word_histogram/2 (exported)
%%
%% Add the word counts from the string to a histogram
%%
word_histogram(String,Histo) -> count_words(words(String), Histo).



