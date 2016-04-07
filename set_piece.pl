/*
Directions for set_piece functions
| - - - |
| 1 2 3 |
| 4 0 6 |
| 7 8 9 |
| - - - |
*/

/*
move a piece to Move with color Color and change other pieces if needed
*/
set_piece(Board, Move, Color, FinalBoard):-
  initChange(Board, Move, Color, AnsBoard),
  directionalChanges(AnsBoard, Move, Color, FinalBoard),
  not(equal2D(AnsBoard, FinalBoard)).

directionalChanges(Board, Move, Color, FinalBoard):-
  [N|T] = Move,
  [M|_] = T,
  NPlus1 is -1,
  MPlus1 is -1,
  TmpN1 is N + NPlus1,
  TmpM1 is M + MPlus1,
  directionalChange(Board,     TmpN1, TmpM1, NPlus1, MPlus1, Color, AnsBoard1),   %1
  NPlus2 is -1,
  MPlus2 is  0,
  TmpN2 is N + NPlus2,
  TmpM2 is M + MPlus2,
  directionalChange(AnsBoard1, TmpN2, TmpM2, NPlus2, MPlus2, Color, AnsBoard2),   %2
  NPlus3 is -1,
  MPlus3 is +1,
  TmpN3 is N + NPlus3,
  TmpM3 is M + MPlus3,
  directionalChange(AnsBoard2, TmpN3, TmpM3, NPlus3, MPlus3, Color, AnsBoard3),   %3
  NPlus4 is  0,
  MPlus4 is -1,
  TmpN4 is N + NPlus4,
  TmpM4 is M + MPlus4,
  directionalChange(AnsBoard3, TmpN4, TmpM4, NPlus4, MPlus4, Color, AnsBoard4),   %4
  NPlus6 is  0,
  MPlus6 is +1,
  TmpN6 is N + NPlus6,
  TmpM6 is M + MPlus6,
  directionalChange(AnsBoard4, TmpN6, TmpM6, NPlus6, MPlus6, Color, AnsBoard6),   %6
  NPlus7 is +1,
  MPlus7 is -1,
  TmpN7 is N + NPlus7,
  TmpM7 is M + MPlus7,
  directionalChange(AnsBoard6, TmpN7, TmpM7, NPlus7, MPlus7, Color, AnsBoard7),   %7
  NPlus8 is +1,
  MPlus8 is  0,
  TmpN8 is N + NPlus8,
  TmpM8 is M + MPlus8,
  directionalChange(AnsBoard7, TmpN8, TmpM8, NPlus8, MPlus8, Color, AnsBoard8),   %8
  NPlus9 is +1,
  MPlus9 is +1,
  TmpN9 is N + NPlus9,
  TmpM9 is M + MPlus9,
  directionalChange(AnsBoard8, TmpN9, TmpM9, NPlus9, MPlus9, Color, FinalBoard).  %9

/*
move a piece to Move with color Color
*/
initChange(Board, Move, Color, AnsBoard):-
  [N|T] = Move,
  [M|_] = T,
  change2D(Color, N, M, Board, AnsBoard).

/*
change other pieces after move a piece to Move with color Color,
know direction with NPlus and MPlus
*/
directionalChange(Board, TmpN, TmpM, NPlus, MPlus, Color, FinalBoard):-
  colorChange(Board, TmpN, TmpM, NPlus, MPlus, Color, FinalBoard), !.

directionalChange(Board, _, _, _, _, _, Board).

colorChange(Board, N, M, NPlus, MPlus, Color, FinalBoard):-
  get2D(N, M, Board, ItemColor),
  ItemColor \= Color,
  member(ItemColor, [x, o]),
  TmpN is N + NPlus,
  TmpM is M + MPlus,
  colorChange(Board, TmpN, TmpM, NPlus, MPlus, Color, TmpBoard),
  change2D(Color, N, M, TmpBoard, FinalBoard).

colorChange(Board, N, M, NPlus, MPlus, Color, FinalBoard):-
  get2D(N, M, Board, ItemColor),
  ItemColor \= Color,
  member(ItemColor, [x, o]),
  TmpN is N + NPlus,
  TmpM is M + MPlus,
  get2D(TmpN, TmpM, Board, NextItemColor),
  NextItemColor == Color,
  change2D(Color, N, M, Board, FinalBoard).
