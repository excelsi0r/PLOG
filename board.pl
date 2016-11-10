:-use_module(library(lists)).
:-use_module(library(random)).

:-include('bubblesort.pl').

:- 	dynamic
	board/1,
	case/1,
	case_p1/1,
	case_p2/1.

%Board, Saucer, Counter.

board_default( [[40,41,42,43,44,45,46,47,48,49,10],
				[39,0,0,0,0,0,0,0,0,0,11],
				[38,0,0,0,0,0,0,0,0,0,12],
				[37,0,0,0,0,0,0,0,0,0,13],
				[36,0,0,0,0,0,0,0,0,0,14],
				[35,0,0,0,0,0,0,0,0,0,15],
				[34,0,0,0,0,0,0,0,0,0,16],
				[33,0,0,0,0,0,0,0,0,0,17],
				[32,0,0,0,0,0,0,0,0,0,18],
				[31,0,0,0,0,0,0,0,0,0,19],
				[30,29,28,27,26,25,24,23,22,21,20]]).

board(_).

case_default(	[1,1,1,1,1,1,1,1,1,1,
				 2,2,2,2,2,2,2,2,2,2,
				 3,3,3,3,3,3,3,3,3,3,
				 4,4,4,4,4,4,4,4,4,4,
				 5,5,5,5,5,5,5,5,5,5,
				 6,6,6,6,6,6,6,6,6,6]).

case(_).				 

counter([1000,2000,3000,4000,5000]).

matrix_coord([0,1,2,3,4,5,6,7,8]).

%display
display_table(_):- 
			nl,
			matrix_coord(M),
			board(TABLE),
			counter(COUNTER),
			print_matrix_up(M, 0),
			print_table(TABLE, M, 0), 
			print_matrix_up(M, 0),
			%nl,
			%print_counter_border(_),
			%print_counter(COUNTER),
			%print_counter_border(_),
			nl.

			
%reset
reset(_):- 	
			board_default(DEFAULT),
			asserta(board(DEFAULT)),
			case_default(DEFCASE),
			asserta(case(DEFCASE)),
			case_player_default(DEFCASEPLAYER),
			asserta(case_p1(DEFCASEPLAYER)),
			asserta(case_p2(DEFCASEPLAYER)).
			
%distribute flowers to players
distribute_flowers(0,_):- 
							case_p1(CASEP1),
							bubble_sort(CASEP1, NEWCASE1),
							asserta(case_p1(NEWCASE1)),
							
							case_p2(CASEP2),
							bubble_sort(CASEP2, NEWCASE2),
							asserta(case_p2(NEWCASE2)).
							
									
distribute_flowers(N,NFlowers):- 
									generate_Index(NFlowers,Index1),
									take_flower_from_case(Index1, Val),
									give_flower_p1(Val),
									
									NFlowers1 is NFlowers - 1,
									
									generate_Index(NFlowers1,Index2),
									take_flower_from_case(Index2, Val1),
									give_flower_p2(Val1),
									
									N1 is N - 1,
									NFlowers2 is NFlowers1 - 1,
									distribute_flowers(N1, NFlowers2).
generate_Index(NFlowers, Val):-

									L is 1.0,
									U is NFlowers,
									random(L,U,Val1),
									Val is integer(Val1).
									
take_flower_from_case(N, Val):- 
									case(CASE),
									nth1(N, CASE, Val,NEWCASE),
									asserta(case(NEWCASE)).	

give_flower_p1(Val):- 
						case_p1(CASEP1), 
						append(CASEP1, [Val], NEWCASE),
						asserta(case_p1(NEWCASE)).
give_flower_p2(Val):- 	
						case_p2(CASEP2),
						append(CASEP2, [Val], NEWCASE),
						asserta(case_p2(NEWCASE)).
									
%random put trees in board
place_trees(0).
place_trees(N):- 
					generate_X_Y_Val(X, Y, Val),
					place_tree(X,Y,Val,N).
					
place_tree(X, Y, Val, N):- 
							Val == 0,
							place_elem_table(X, Y, 7),
							N1 is N - 1,
							place_trees(N1).
							
place_tree(X, Y, Val, N):- 
							Val \= 0,
							X = X, Y = Y,
							place_trees(N).
			

generate_X_Y_Val(X, Y, Val):- 
								L is 2.0,
								U is 10.0,
								random(L,U,X1),
								random(L,U,Y1),
								X is integer(X1),
								Y is integer(Y1),
								get_elem(X, Y, Val).
			
			
			
%get elem from board
get_elem(X, Y, Val):- 
						X >= 1, Y >= 1, X =< 11, Y =< 11,
						board(TABLE),
						nth1(Y, TABLE, Line), 
						nth1(X, Line, Val).
						
get_elem(X, Y, Val):- 
						X = X, Y = Y,
						Val = 'null'.
						
%display elem
display_elem_table(X, Y):-
								get_elem(X, Y, Val),
								print(Val),
								nl.
								
%place element in table
place_elem_table(X,Y,Elem):-
								get_elem(X,Y,Val),
								Val \= 'null',
								board(TABLE),
								place_elem(X,Y,Elem,TABLE,NewTable),
								retract(board(TABLE)),
								asserta(board(NewTable)).
								
place_elem_table(X,Y,Elem):-
								X = X, Y = Y,
								Elem = Elem,
								write('Invalid Coords to place '), nl.
								

									
place_elem(X,Y,Elem,[Head | Tail], [HeadNew | TailNew]):- 
															Y == 0, 
															place_elem_line(X,Elem,Head, HeadNew),
															TailNew = Tail.
										
place_elem(X,Y,Elem,[Head | Tail], [HeadNew | TailNew]):- 
															Y > 0, 
															Y1 is Y - 1,
															HeadNew = Head,
															place_elem(X, Y1, Elem, Tail, TailNew).
										
										
place_elem_line(X, Elem, [_| Tail], [HeadNew | TailNew]):- 
																
																X == 0,
																HeadNew = Elem,
																TailNew = Tail.

place_elem_line(X,Elem,[Head | Tail], [HeadNew | TailNew]):- 

																X > 0,
																X1 is X - 1,
																HeadNew = Head,
																place_elem_line(X1, Elem, Tail, TailNew).
						
						
						
		
			
%Print Table
print_table([], [], NUM):- NUM \= 0, nl, nl.
print_table([Line|Rest], M, NUM):-

							NUM < 1,
							nl, print('    '),
							print_line(Line),
							print_table(Rest, M, NUM + 1).
							
							
print_table([Line|Rest], M, NUM):-

							NUM > 9,
							nl, print('    '),
							print_line(Line),
							print_table(Rest, M, NUM + 1).
							
print_table([Line|Rest], [Index | IRest], NUM):-

							NUM \= 0,
							nl,
							print(Index), print('   '),
							print_line(Line), print('  '),
							print(Index),
							print_table(Rest, IRest, NUM + 1).
							
print_line([]).
print_line([Cell|Rest]):-	
							Cell < 10,
							print_elem(Cell),
							print(' '),
							print_line(Rest).

print_line([Cell|Rest]):-	
							Cell >= 10, Cell < 100,
							NM is mod(Cell, 10),
							print(NM),
							print(' '),
							print_line(Rest).
							
print_line([Cell|Rest]):-	
							Cell >= 100,
							print_player(Cell),
							print(' '),
							print_line(Rest).
							
							
							
%print conversions
print_elem(Cell):- Cell == 0, print('-').
print_elem(Cell):- Cell == 7, print('T').
print_elem(Cell):- Cell == 1, print('w').
print_elem(Cell):- Cell == 2, print('y').
print_elem(Cell):- Cell == 3, print('g').
print_elem(Cell):- Cell == 4, print('b').
print_elem(Cell):- Cell == 5, print('p').
print_elem(Cell):- Cell == 6, print('r').

print_player(Cell):- Cell == 100, print('F').
print_player(Cell):- Cell == 200, print('S').


							
%print matrix uper
print_matrix_up([], NUM) :- NUM \= 0, nl.						
print_matrix_up([Line|Rest], NUM):- 	
									NUM == 0,
									print('      '),
									print(Line),
									print_matrix_up(Rest, NUM + 1).
									
print_matrix_up([Line|Rest], NUM):- 	
									NUM \= 0,
									print(' '),
									print(Line),
									print_matrix_up(Rest, NUM + 1).
									
									
%print counter
print_counter([]):- nl.
print_counter([Line | Rest]):- 
								
								print_counter_elem(Line),
								print('  '),
								print_counter(Rest).
								
%print counter elems
print_counter_elem(Elem):- Elem == 1000, print('T<->F').
print_counter_elem(Elem):- Elem == 2000, print('F<->F').
print_counter_elem(Elem):- Elem == 3000, print('F-->O').
print_counter_elem(Elem):- Elem == 4000, print('T-->O').
print_counter_elem(Elem):- Elem == 5000, print('A-->5').
print_counter_elem(Elem):- Elem == 6000, print('|   |').

%print_counter border
print_counter_border(_):- 	print('---------------------------------'),
							nl.

							
%movement simulation

/*player([ALI, X, Y , YELLOW, WHITE, PURPLE, BLUE, GREEN, SPECIAL])
plant(PLAYER, X,Y, YELLOW, FALSE).*/			
					