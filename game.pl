:-include('display.pl').
:-include('player.pl').

%To play the game
start(TYPE):- 
			
			TYPE == 'pp',
			
			display_elem_table(12,11),
			
			repeat, 
				display_table(_).
				%display_player(_),
				%display_player(_).								