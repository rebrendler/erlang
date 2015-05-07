-module(histo_tests).
-include_lib("eunit/include/eunit.hrl").

blank_string_test() -> 0 = dict:size(histo:word_histogram("")).

string_with_no_words_test() -> 0 = dict:size(histo:word_histogram("!@#* *&!@%")).

word_count_test() -> Histo = histo:word_histogram("olly olly oxen free"),
		     {ok,2} = dict:find("olly",Histo),
		     {ok,1} = dict:find("oxen",Histo),
		     {ok,1} = dict:find("free",Histo).

case_insensitivitiy_test() -> Histo = histo:word_histogram("TEST Test TesT test"),
			    {ok,4} = dict:find("test",Histo).

punctuation_test() -> Histo = histo:word_histogram("Heidy-ho!"),
		      2 = dict:size(Histo),
		      {ok,1} = dict:find("heidy",Histo),
		      {ok,1} = dict:find("ho",Histo).

contraction_test() -> Histo = histo:word_histogram("O'Reilly Won't!"),
		      2 = dict:size(Histo),
		      {ok,1} = dict:find("o'reilly",Histo),
		      {ok,1} = dict:find("won't",Histo).
		      
ignore_leading_trailing_apostrophe_test() -> Histo = histo:word_histogram("'taint 'funny'"),
		      2 = dict:size(Histo),
		      {ok,1} = dict:find("taint",Histo),
		      {ok,1} = dict:find("funny",Histo).
