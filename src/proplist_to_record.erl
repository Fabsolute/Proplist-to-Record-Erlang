-module(proplist_to_record).

%% API
-export([convert/3]).

convert(PropList, Fields, RecordName) ->
  TransformedFields = transform_fields(Fields),
  TransformedPropList = transform_proplist(PropList),
  list_to_tuple(get_lists(TransformedFields, TransformedPropList, [RecordName])).


get_lists([], _Response, Acc) ->
  Acc;

get_lists([Key | T] = _Lookup, Response, Acc) ->
  {_, Value} =
    case lists:keyfind(Key, 1, Response) of
      false ->
        {null, null};
      Otherwise ->
        Otherwise
    end,
  get_lists(T, Response, Acc ++ [Value]).


transform_proplist(List) ->
  transform_proplist(List, []).

transform_proplist([], Acc) ->
  Acc;
transform_proplist([{K, V} | T], Acc) when is_binary(K) ->
  transform_proplist([{binary_to_list(K), V} | T], Acc);
transform_proplist([{K, V} | T], Acc) when is_atom(K) ->
  transform_proplist([{atom_to_list(K), V} | T], Acc);
transform_proplist([{K, V} | T], Acc) when is_list(K) ->
  transform_proplist(T, Acc ++ [{K, V}]).

transform_fields(Fields) ->
  transform_fields(Fields, []).

transform_fields([], Fields) ->
  Fields;
transform_fields([H | T], Fields) when is_atom(H) ->
  transform_fields([atom_to_list(H) | T], Fields);
transform_fields([H | T], Fields) when is_list(H) ->
  transform_fields(T, Fields ++ [H]).
