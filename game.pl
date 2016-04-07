/* solve game */
game(Board, Move, Depth, x) :-
  game(Board, Move, Depth, x, _).

game(Board, Move, Depth, o) :-
  game(Board, Move, Depth, o, _).

game(Board, Move, 1, Color, Max):-
  bestMove(Board, Color, Move, Max),
  !.

game(Board, Move, Depth, x, Max):-
  TmpDepth is Depth - 1,
  solveForChilds(Board, TmpDepth, x, AnsList),
  min2D(AnsList, Move, Max).

game(Board, Move, Depth, o, Max):-
  TmpDepth is Depth - 1,
  solveForChilds(Board, TmpDepth, o, AnsList),
  min2D(AnsList, Move, Max).

solveForChilds(Board, Depth, Color, Ans):-
  forGame(Board, Color, Depth, Ans).

/*
find best move and pos in Board
*/
bestMove(Board, Color, Pos, Max):-
  forCheckMove(Board, Color, List),
  max2D(List, Pos, Max).

/*
count Color if set a piece with cordination Move and color Color,
*/
checkMove(Board, Move, Color, Count):-
  [N|T] = Move,
  [M|_] = T,
  get2D(N, M, Board, ItemColor),
  ItemColor == 0,
  set_piece(Board, Move, Color, TmpBoard),
  counter2D(Color, TmpBoard, Count),
  !.

checkMove(_, _, _, -1).

/*
for on list in two dimention array, to check answer for all
List of List
*/
forCheckMove([_], X, Y, Board, Color, Ans):-
  Move = [X, Y],
  checkMove(Board, Move, Color, Count),
  Ans = [Count],
  !.

forCheckMove(List, X, Y, Board, Color, Ans):-
  [_|T] = List,
  Move = [X, Y],
  checkMove(Board, Move, Color, Count),
  TmpY is Y + 1,
  forCheckMove(T, X, TmpY, Board, Color, TmpAns),
  append([Count], TmpAns, Ans).

forCheckMove([I], X, Board, Color, Ans):-
  forCheckMove(I, X, 1, Board, Color, TmpAns),
  Ans = [TmpAns],
  !.

forCheckMove(List, X, Board, Color, Ans):-
  [H|T] = List,
  forCheckMove(H, X, 1, Board, Color, TmpAns1),
  TmpX is X + 1,
  forCheckMove(T, TmpX, Board, Color, TmpAns2),
  append([TmpAns1], TmpAns2, Ans).

forCheckMove(Board, Color, Ans):-
  forCheckMove(Board, 1, Board, Color, Ans).

/*
for on list in two dimention array, to check answer for all
List of List
*/

runGame(Board, Move, Depth, x, Count):-
  [N|T] = Move,
  [M|_] = T,
  get2D(N, M, Board, ItemColor),
  ItemColor == 0,
  set_piece(Board, Move, x, FinalBoard),
  game(FinalBoard, _, Depth, o, Count),
  !.

runGame(Board, Move, Depth, o, Count):-
  [N|T] = Move,
  [M|_] = T,
  get2D(N, M, Board, ItemColor),
  ItemColor == 0,
  set_piece(Board, Move, o, FinalBoard),
  game(FinalBoard, _, Depth, x, Count),
  !.

runGame(_, _, _, _, 100).

forGame([_], X, Y, Board, Color, Depth, Ans):-
  Move = [X, Y],
  runGame(Board, Move, Depth, Color, Count),
  Ans = [Count],
  !.

forGame(List, X, Y, Board, Color, Depth, Ans):-
  [_|T] = List,
  Move = [X, Y],
  runGame(Board, Move, Depth, Color, Count),
  TmpY is Y + 1,
  forGame(T, X, TmpY, Board, Color, Depth, TmpAns),
  append([Count], TmpAns, Ans).

forGame([I], X, Board, Color, Depth, Ans):-
  forGame(I, X, 1, Board, Color, Depth, TmpAns),
  Ans = [TmpAns],
  !.

forGame(List, X, Board, Color, Depth, Ans):-
  [H|T] = List,
  forGame(H, X, 1, Board, Color, Depth, TmpAns1),
  TmpX is X + 1,
  forGame(T, TmpX, Board, Color, Depth, TmpAns2),
  append([TmpAns1], TmpAns2, Ans).

forGame(Board, Color, Depth, Ans):-
  forGame(Board, 1, Board, Color, Depth, Ans).
