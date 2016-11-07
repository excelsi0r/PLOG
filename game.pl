:-include('board.pl').
:-include('players.pl').

%To play the game
start(TYPE):- 
			TYPE == 'pp',
			
			%display_elem_table(12,11),
			%place_elem_table(2,2,3),
			reset(_),
			place_trees(3),
			
			repeat, 
				display_table(_),
			!.
				%display_player(_),		%display_player(_).