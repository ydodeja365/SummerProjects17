
%%%-------------------------------------------------------------------
%%% @author Praveen Gupta
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. May 2017 09:21 PM
%%%-------------------------------------------------------------------
-module(assign2).
-author("Praveen Gupta").
%% API
-export([unique/1, uniq/1, freq/2, replicate/2, rep/2, reverse/1, zip/2, fac/1, fact/1,
  zipp/2, fib/1, bsort/1, isort/1, ssort/1, msort/1, merge/2, qsort/1, timer/2]).

%Takes a List and returns the list without repetition of elements.
unique(X) -> unique(X, []).
unique([], N) -> N;
unique([H | T], N) ->
  case lists:member(H, N) of
    true -> unique(T, N);
    false -> unique(T, N ++ [H])
  end.

%Takes  List and returns the list containing only unique elements.
uniq(X) -> [A || A <- X, freq(A, X) == 1].

%Takes a List and returns the count of an element in the list.
freq(_, []) -> 0;
freq(A, [H | T]) ->
  if
    A == H -> 1 + freq(A, T);
    true -> freq(A, T)
  end.

%Returns a list containing an element with desired repetions.
replicate(N, X) -> replicate(N, X, []).
replicate(0, _, A) -> A;
replicate(N, X, A) -> replicate(N - 1, X, A ++ [X]).

%Another approach for replicate.
rep(1, X) -> [X];
rep(N, X) -> rep(N - 1, X) ++ [X].

%Takes a list and returns its reverse list.
reverse(X) -> reverse(X, []).
reverse([], A) -> A;
reverse([H | T], A) -> reverse(T, [H] ++ A).

%Takes 2 list and returns a list with tuples of corresponding elements.
zip(X, Y) -> zip(X, Y, []).
zip([], _, A) -> A;
zip(_, [], A) -> A;
zip([XH | XT], [YH | YT], A) -> zip(XT, YT, A ++ [{XH, YH}]).

%Another approach for zip.
zipp([X | XT], [Y | YT]) -> [{X, Y} | zip(XT, YT)];
zipp([], []) -> [].

%Returns factorial of given no.
fac(0) -> 1;
fac(N) -> N * fac(N - 1).

%Another approach for factorial using tail recursion.
fact(N) -> fact(N, 1).
fact(0, F) -> F;
fact(N, F) -> fact(N - 1, F * N).

%Prints N elements of the fibonacci series.
fib(N) ->
  case N of
    1 -> [1];
    2 -> [1, 1];
    _ -> reverse(fib(N, [1, 1]))
  end.
fib(2, A) -> A;
fib(N, A) -> fib(N - 1, [hd(A) + hd(tl(A))] ++ A).

%fibtime(N) -> timer:tc(assign2, fib, [N]).

%Sorts the given list using bubble sort algorithm.
bsort(List) -> bsort(List, [], []).
bsort([A | []], _, Sorted) -> [A] ++ Sorted;
bsort([A, B | []], Temp, Sorted) ->
  if
    A < B -> bsort(lists:droplast(Temp ++ [A, B]), [], [B] ++ Sorted);
    true -> bsort(lists:droplast(Temp ++ [B, A]), [], [A] ++ Sorted)
  end;
bsort([A, B | T], Temp, Sorted) ->
  if
    A < B -> bsort([B | T], Temp ++ [A], Sorted);
    true -> bsort([A | T], Temp ++ [B], Sorted)
  end.

%Sorts the given list using insertion sort algorithm.
isort(X) -> isort(X, []).
isort([], Y) -> Y;
isort(X, Y) -> Min = lists:min(X),
  isort(lists:delete(Min, X), Y ++ [Min]).

%Sorts the given list using selection sort algorithm.
ssort(List) -> ssort(List, List, []).
ssort([A | []], _, Sorted) -> [A] ++ Sorted;
ssort([A, B | []], Temp, Sorted) ->
  if
    A > B -> ssort(lists:delete(A, Temp), lists:delete(A, Temp), [A] ++ Sorted);
    true -> ssort(lists:delete(B, Temp), lists:delete(B, Temp), [B] ++ Sorted)
  end;
ssort([H | T], Temp, Sorted) ->
  Last = lists:last(T),
  if
    H < Last -> ssort(T, Temp, Sorted);
    true -> ssort(lists:droplast(T) ++ [H], Temp, Sorted)
  end.

%Sorts the given list using merge sort algorithm.
msort([]) -> [];
msort([H | []]) -> [H];
msort(X) -> {F, S} = lists:split(length(X) div 2, X),
  merge(msort(F), msort(S)).

%Merges 2 sorted lists into 1 sorted list
merge(X, []) -> X;
merge([], X) -> X;
merge([X | XT], [Y | YT]) ->
  if
    X < Y -> [X] ++ merge(XT, [Y | YT]);
    true -> [Y] ++ merge([X | XT], YT)
  end.

%Sorts the given list using quick sort algorithm.
qsort([]) -> [];
qsort([H | T]) -> qsort([X || X <- T, X =< H]) ++ [H] ++ qsort([X || X <- T, X > H]).

%Returns time taken by given function and parameter in microseconds
timer(Func, Para) -> {T, _} = timer:tc(assign2, Func, [Para]),
  io:fwrite("~w microseconds~n", [T]).