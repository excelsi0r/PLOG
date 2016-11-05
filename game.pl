:-use_module(library(lists)).

%Board, Saucer, Counter.
board( [[40,41,42,43,44,45,46,47,48,49,10],
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
		

counter([1000,2000,3000,4000,5000]).

matrix_coord([0,1,2,3,4,5,6,7,8]).

%To play the game
main(_):- display_table(_).
			
display_table(_):- 
			nl,
			matrix_coord(M),
			board(TABLE),
			counter(COUNTER),
			print_matrix_up(M, 0),
			print_table(TABLE, M, 0), 
			print_matrix_up(M, 0),
			nl,
			print_counter_border(_),
			print_counter(COUNTER),
			print_counter_border(_),
			nl.

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

					

					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					