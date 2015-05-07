-module('anagram').
-export([is_anagram/2]).

%% letter_histogram/2
%%
%% Create a dictionary containing the counts of every letter in
%% the specified string
letter_histogram(String) ->
     count_letters(String,dict:new()).
    
count_letters([],Dict) -> Dict;
count_letters([C|R], Dict) ->
    New = dict:update_counter(C,1,Dict),
    count_letters(R,New).

%% compare_string_to_histogram/2
%%
%% Compares the specified string to the letter histogram provided,
%% and returns true if they match.  This runs in linear time, and 
%% will short-circuit as soon as it encounters any difference.
compare_string_to_histogram([], _) -> true ; 
compare_string_to_histogram([C|R], Histo) ->
    case dict:find(C,Histo) of
	error -> false;
	{ok,0} -> false;
	_Else ->
	    New = dict:update_counter(C,-1,Histo),   
	    compare_string_to_histogram(R,New)
        end.

%% is_anagram/2 (exported)
%%
%% Test whether String1 is an anagram of String2
%%
is_anagram(String1, String2) ->
    % strings must be the same length for us to even check...
    (string:len(String1) == string:len(String2))
	and compare_string_to_histogram(string:to_lower(String1),letter_histogram(string:to_lower(String2))).
	       
