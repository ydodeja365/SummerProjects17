-module(assignment2).
-export([qsort/1, insort/1, bubsort/1, selsort/1, mergesort/1, unique/1, replicate/2, reverse/1, zip/2, fibonacci/1]).

qsort([]) -> [];
qsort([Pivot|T]) ->
qsort([X||X <- T, X<Pivot]) ++ [Pivot] ++ qsort([X||X <- T, X>=Pivot]).

insort([H|T]) -> insort([H],T).
insort(Sorted,[]) -> Sorted;
insort(Sorted,[H|T]) -> insort([X||X <- Sorted, X<H]++[H]++[X||X <- Sorted, X>=H],T).

bubsort(Unsorted) -> bubsort(Unsorted, [], []).
bubsort([H|[H1|T]], Passed, Sorted) when T==[], H<H1 -> bubsort(Passed++[H], [], [H1]++Sorted);
bubsort([H|[H1|T]], Passed, Sorted) when T==[], H>=H1 -> bubsort(Passed++[H1], [], [H]++Sorted);
bubsort([H|T], [], Sorted) when T==[] -> bubsort([], [], [H]++Sorted);
bubsort([H|[H1|T]], Passed, Sorted) when H<H1 -> bubsort([H1]++T, Passed++[H], Sorted);
bubsort([H|[H1|T]], Passed, Sorted) when H>=H1 -> bubsort([H]++T, Passed++[H1], Sorted);
bubsort([], [], Sorted) -> Sorted.

selsort(Unsorted) -> selsort(Unsorted,[],[]).
selsort([H|T],Passed, Sorted) -> selsort([X||X <- T , X<H],[H]++Passed++[X||X <- T , X>=H], Sorted);
selsort([],[H|T],Sorted) -> selsort(T,[],Sorted++[H]);
selsort([], [], Sorted) -> Sorted.

mergesort(Unsorted) -> mergesort(Unsorted, []).
mergesort([], [H|[H1|T]]) -> mergesort(H,H1,[],T,[]);
mergesort([],[H|T]) when T== [] -> H;
mergesort([H|T], SplitList) -> mergesort(T, SplitList++[[H]]).
mergesort([],[],Sorted,T,Newlist) -> mergesort(Sorted,T,Newlist);
mergesort([],L2,Sorted,T,NewList) -> mergesort([],[],Sorted++L2,T,NewList);
mergesort(L1,[],Sorted,T,NewList) -> mergesort([],[],Sorted++L1,T,NewList);
mergesort([H1|T1],[H2|T2],Sorted,T,NewList) when H1<H2-> mergesort(T1,[H2|T2],Sorted++[H1],T,NewList);
mergesort([H1|T1],[H2|T2],Sorted,T,NewList) when H2=<H1-> mergesort([H1|T1],T2,Sorted++[H2],T,NewList).
mergesort(Sorted,[],NewList) -> mergesort([], NewList++[Sorted]);
mergesort(Sorted,[H|T],NewList) when T==[] -> mergesort(H,[],[],T,NewList++[Sorted]);
mergesort(Sorted,[H|[H1|T]],NewList) -> mergesort(H,H1,[],T,NewList++[Sorted]).

unique(List) -> unique(List,[]).
unique([H|T], NewList) -> unique([X||X <- T, X /= H],NewList++[H]);
unique([],NewList) -> NewList.

replicate(X,N) -> replicate([],X,N).
replicate(List,_,0) -> List;
replicate(List,X,N) -> replicate(List++[X],X,N-1).

reverse(List) -> reverse(List, []).
reverse([],NewList) -> NewList;
reverse([H|T], NewList) -> reverse(T,[H]++NewList).

zip(List1, List2) -> zip(List1, List2, []).
zip(T1,T2,NewList) when T1==[]; T2==[] -> NewList;
zip([H1|T1], [H2|T2], NewList) -> zip(T1,T2,NewList++[{H1,H2}]).

fibonacci(1) -> [0];
fibonacci(2) -> [0,1];
fibonacci(N) -> fibonacci(N-2,[0,1],[0,1]).
fibonacci(0,Series,_) -> Series;
fibonacci(N,Series,[H|[H1|_]]) -> fibonacci(N-1,Series++[H+H1],[H1,H+H1]).
