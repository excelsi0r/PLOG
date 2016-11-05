:-use_module(library(lists)).

%Board, Saucer, Counter.
board( [[0,1,2,3,4,5,6,7,8,9,0],
		[9,'-','-','-','-','-','-','-','-','-',1],
		[8,'-','-','-','-','-','-','-','-','-',2],
		[7,'-','-','-','-','-','-','-','-','-',3],
		[6,'-','-','-','-','-','-','-','-','-',4],
		[5,'-','-','-','-','-','-','-','-','-',5],
		[4,'-','-','-','-','-','-','-','-','-',6],
		[3,'-','-','-','-','-','-','-','-','-',7],
		[2,'-','-','-','-','-','-','-','-','-',8],
		[1,'-','-','-','-','-','-','-','-','-',9],
		[0,9,8,7,6,5,4,3,2,1,0]]).
		
saucer([['Bot  ','Ali  ','Marty',' Cob  ','Robby']]).

counter([['T<->F','F<->F','F->O','T->O','A->5']]).

%To play the game
main(_):-
			board(TABLE),
			print_table(TABLE),nl,
			counter(BCOUNTER),
			print_black_counter(BCOUNTER),
			saucer(SAUCER),nl,
			print_saucer(SAUCER).

%Print Table
print_table([]).
print_table([Line|Rest]):-
							nl,
							print_line(Line),
							print_table(Rest).
							
print_line([]).
print_line([Cell|Rest]):-	
							print(Cell),
							print(' '),
							print_line(Rest).

							
%Print the flying saucer
print_saucer(ALIENS):- 	flying_saucer_up(FSU),
						print_table(FSU),
						print_table(ALIENS),					
						flying_saucer_down(FSD),
						print_table(FSD),
						nl.
					
%Print for Black Counter
print_black_counter(COUNTER):-	counter_up_down(CUP),
								print_table(CUP),
								print_table(COUNTER),
								print_table(CUP).
							
					
					
%printing elems for Saucer
empty_alien('    ').
flying_saucer_up([ 	['             ____             '],
					['   _________|    |_________   '],
					[' _|________________________|_ '],
					['|____________________________|']]).
					
flying_saucer_down([['|____________________________|'],
					[' |________          ________| '],
					['          |________|          ']]).
					
%printing elems for Counter 
empty_counter_elem('     ').
counter_up_down([['--------------------------']]).

%movement simulation
player([ALI, X, Y , YELLOW, WHITE, PURPLE, BLUE, GREEN, SPECIAL])
plant(PLAYER, X,Y, YELLOW, FALSE).

					

					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					