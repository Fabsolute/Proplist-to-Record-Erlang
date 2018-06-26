-module(proplist_example).
-include("../include/proplist_to_record.hrl").
%% API
-export([test_record/0]).

-record(my_record, {
  id,
  username,
  password,
  name,
  surname
}).

get_binary_user_proplist() ->
  [
    {<<"id">>, "1"},
    {<<"username">>, "fabsolute"},
    {<<"password">>, "123456"},
    {<<"name">>, "ahmet"},
    {<<"surname">>, "turk"}
  ].

get_user_proplist() ->
  [
    {"id", "1"},
    {"username", "fabsolute"},
    {"password", "123456"},
    {"name", "ahmet"},
    {"surname", "turk"}
  ].

test_record() ->
  BinaryPropList = get_binary_user_proplist(),
  AnotherPropList = get_user_proplist(),

  Record1 = ?proplist_to_record(BinaryPropList, my_record),
  Record2 = ?proplist_to_record(AnotherPropList, my_record),
  Record1#my_record.name ++ " " ++ Record2#my_record.surname.
