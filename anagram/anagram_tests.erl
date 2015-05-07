-module(anagram_tests).
-include_lib("eunit/include/eunit.hrl").

blank_string_test() -> anagram:is_anagram("","").

blank_rhs_test() -> not anagram:is_anagram("hello","").

blank_lhs_test() -> not anagram:is_anagram("","world").

match_test() -> anagram:is_anagram("gallery","gallery").

anagram_test() -> anagram:is_anagram("gallery","regally").

not_an_anagram_test() -> not anagram:is_anagram("gallery","galleri").
    
substring_test() -> not anagram:is_anagram("gallery","galley").

case_insentitivity_test() -> anagram:is_anagram("gallery","REGALLY").
