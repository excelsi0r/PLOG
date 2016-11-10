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
				
				reset(_),
				place_trees(3),
				distribute_flowers(27,60),		
				
				set_state_p1(_),
				print_state(_),
				
				repeat, 
					display_table(_),
					display_p1_case(_),
					display_p2_case(_),
				!.
					%display_player(_),		%display_player(_).
					
set_state_start(_):- asserta(state('start')).
set_state_p1(_):- asserta(state('p1')).
set_state_p2(_):- asserta(state('p2')).
set_state_end(_):- asserta(state('end')).


print_state(_):-  	
					state(Val),
					Val == 'p1', nl,
					print('Player 1 make your move.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'p2', nl,
					print('Player 2 make your move.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'end', nl,
					print('Game is finished.'), nl.
					
print_state(_):-  	
					state(Val),
					Val == 'start', nl,
					print('Loading Game ...'), nl.