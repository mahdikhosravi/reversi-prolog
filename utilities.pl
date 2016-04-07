/*
get an object in a one dimention and two dimention array,
List and List of List
*/
get1D(1, List, Result):-
  [Result|_] = List,
  !.

get1D(N, List, Result):-
  [_|T] = List,
  TmpN is N - 1,
  get1D(TmpN, T, Result).

get2D(1, M, List, Result):-
  [H|_] = List,
  get1D(M, H, Result),
  !.

get2D(N, M, List, Result):-
  [_|T] = List,
  TmpN is N - 1,
  get2D(TmpN, M, T, Result).

/*
change an object in a one dimention and two dimention array,
List and List of List
*/
change1D(X, 1, List, Result):-
  [_|T] = List,
  append([X], T, Result),
  !.

change1D(X, N, List, Result):-
  [H|T] = List,
  TmpN is N - 1,
  change1D(X, TmpN, T, TmpResult),
	append([H], TmpResult, Result).

change2D(X, 1, M, List, Result):-
  [H|T] = List,
  change1D(X, M, H, TmpResult),
  append([TmpResult], T, Result),
  !.

change2D(X, N, M, List, Result):-
  [H|T] = List,
  TmpN is N - 1,
  change2D(X, TmpN, M, T, TmpResult),
  append([H], TmpResult, Result).

/*
count an object in a one dimention array and two dimention array,
List and List of List
*/
counter1D(_, [], 0):- !.

counter1D(X, [X|T], N):-
  counter1D(X, T, TmpN),
  N is TmpN + 1,
  !.

counter1D(X, [_|T], N):-
  counter1D(X, T, N).

counter2D(X, List, N):-
  [H|T] = List,
  counter1D(X, H, TmpN1),
  counter2D(X, T, TmpN2),
  N is TmpN1 + TmpN2.

counter2D(_, [], 0):- !.

/*
check equality of two list in a one dimention array and two dimention array,
List and List of List
*/
equal1D([], []):- !.

equal1D(List1, List2):-
  [H1|T1] = List1,
  [H2|T2] = List2,
  H1 == H2,
  equal1D(T1, T2).

equal2D([], []):- !.

equal2D(List1, List2):-
  [H1|T1] = List1,
  [H2|T2] = List2,
  equal1D(H1, H2),
  equal2D(T1, T2).

/*
max and pos of max in list in a one dimention array and two dimention array,
List and List of List
*/
difMax1D(_, Val1, Pos2, Val2, Pos, Max):-
  Val1 < Val2,
  Pos is Pos2 + 1,
  Max is Val2,
  !.

difMax1D(Pos, Max, _, _, Pos, Max).

max1D([H], 1, H):- !.

max1D(List, Pos, Max):-
  [H|T] = List,
  max1D(T, TmpPos, TmpMax),
  difMax1D(1, H, TmpPos, TmpMax, Pos, Max).

difMax2D(_, Val1, Pos2, Val2, Pos, Max):-
  Val1 < Val2,
  [N|T] = Pos2,
  [M|_] = T,
  TmpN is N + 1,
  Pos = [TmpN, M],
  Max is Val2,
  !.

difMax2D(Pos, Max, _, _, Pos, Max).

max2D([H], [1, Pos], Max):-
  max1D(H, Pos, Max),
  !.

max2D(List, Pos, Max):-
  [H|T] = List,
  max2D(T, TmpPos1, TmpMax1),
  max1D(H, TmpPos2, TmpMax2),
  difMax2D([1, TmpPos2], TmpMax2, TmpPos1, TmpMax1, Pos, Max).


/*
min and pos of min in list in a one dimention array and two dimention array,
List and List of List
*/
difMin1D(_, Val1, Pos2, Val2, Pos, Min):-
      Val1 > Val2,
      Pos is Pos2 + 1,
      Min is Val2,
      !.

difMin1D(Pos, Min, _, _, Pos, Min).

min1D([H], 1, H):- !.

min1D(List, Pos, Min):-
  [H|T] = List,
  min1D(T, TmpPos, TmpMin),
  difMin1D(1, H, TmpPos, TmpMin, Pos, Min).

difMin2D(_, Val1, Pos2, Val2, Pos, Min):-
  Val1 > Val2,
  [N|T] = Pos2,
  [M|_] = T,
  TmpN is N + 1,
  Pos = [TmpN, M],
  Min is Val2,
  !.

difMin2D(Pos, Min, _, _, Pos, Min).

min2D([H], [1, Pos], Min):-
  min1D(H, Pos, Min),
  !.

min2D(List, Pos, Min):-
  [H|T] = List,
  min2D(T, TmpPos1, TmpMin1),
  min1D(H, TmpPos2, TmpMin2),
  difMin2D([1, TmpPos2], TmpMin2, TmpPos1, TmpMin1, Pos, Min).
