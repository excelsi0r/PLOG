:-include('board.pl').
:-include('players.pl').

:- 	dynamic
	state/1.

state(_).

%To play the game
start(TYPE):- 
				TYPE == 'pp',
				
				%display_elem_table(12,11),
				%place_elem_table(2,2,3),
				
				set_state_start(_),
				print_state(_),
				
				reset_board(_),
				reset_players(_),
				
				place_trees(3),
				distribute_flowers(27,60),
				

				place_p1(11,2),
				place_p2(11,3),
				
				
				set_state_p1(_),
				print_state(_),
				
				repeat, 
						display_table(_),
						display_p1_case(_),
						display_p1_score(_),
						nl,
						display_p2_case(_),
						display_p2_score(_),
				!.
						%display_player(_),		%display_player(_).
					
set_state_start(_):- asserta(state('start')).
set_state_p1(_):- asserta(state('p1')).
set_state_p2(_):- asserta(state('p2')).
set_state_end(_):- asserta(state('end')).


print_state(_):-  	
					state(Val),
					Val == 'p1', nl,
					print('Player 1 or player "F" make your move.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'p2', nl,
					print('Player 2 or player "S" make your move.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'end', nl,
					print('Game is finished.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'start', nl,
					print('Loading Game ...'), nl.
					
%place player in positions
place_p1(X,Y):- 
				get_elem(X, Y, Val),
				Val1 is integer(Val),
				Elem is Val1 + 100,
				place_elem_table(X, Y, Elem).
				
place_p2(X,Y):- 
				get_elem(X, Y, Val),
				Val1 is integer(Val),
				Elem is Val1 + 200,
				place_elem_table(X, Y, Elem).
				




