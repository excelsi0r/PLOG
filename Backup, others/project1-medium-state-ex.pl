:-use_module(library(lists)).

%board, Saucer, Counter.
board( [[0,1,2,3,4,'A',6,7,8,9,0],
		[9,'-','-','-','-','-','-','-','-','-',1],
		[8,'-','-','y','-','b','-','g','g','-',2],
		[7,'-','-','y','-','r','r','-','g','-',3],
		[6,'-','-','y','T','r','r','r','-','-','R'],
		[5,'-','-','y','y','-','T','-','p','-',5],
		[4,'-','p','p','b','b','-','p','p','-',6],
		[3,'-','w','p','-','g','g','-','-','p','B'],
		[2,'-','w','T','-','-','g','-','b','p',8],
		[1,'w','w','-','-','-','-','-','-','-',9],
		[0,9,8,7,6,5,4,3,2,1,0]]).
		
saucer([['     ','     ','Marty',' Cob  ','     ']]).

counter([['T<->F','     ','F->O','T->O','     ']]).

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

					

					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					