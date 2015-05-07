-module(beersong).
-export([sing/1]).
-export([print_verse/2]).
-export([print_verse/3]).

print_verse(Count,Remain) ->
    print_verse(Count, "take one down and pass it around", Remain).

print_verse(Count, Action, Remain) ->
    io:fwrite("~s of beer on the wall, ~s of beer.~n", [Count, Count]),    
    io:fwrite("~s, ~s of beer on the wall.~n", [Action, Remain]).


verse(N,Total) ->
    case N of
	0 -> print_verse("no more bottles", "go to the store and get some more", io_lib:format("~b bottles",[Total]));
	1 -> 
	    print_verse("1 bottle", "no more bottles"), 
	    verse(0,Total);
	_Else ->
	    print_verse(io_lib:format("~b bottles",[N]), io_lib:format("~b bottles",[N-1])), 
	    verse(N-1,Total)
    end.
    
sing(N) ->
     verse(N,N).

