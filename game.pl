:-include('board.pl').
:-include('players.pl').

:- 	dynamic
	state/1.

state(_).

%To play the game
start(TYPE):- 
				TYPE == 'pp',
								
				%set loading/start state 
				set_state_start(_),
				print_state(_),
				
				%reset content
				reset_board(_),
				reset_players(_),
				
				%place 3 random 3 in board and
				%distribute random 27 of 60 to each player from the case
				place_trees(3),
				distribute_flowers(27,60),
				
				%initial positions for player 1 and player 2
				place_p1(11,2),
				place_p2(11,3),
				
				%set state p1
				set_state_p1(_),
				print_state(_),
				
				play_p1(2,2,2),
				
				repeat, 
						display_table(_),
						display_p1_case(_),
						display_p1_score(_),
						nl,
						display_p2_case(_),
						display_p2_score(_),
				!.
						%display_player(_),		%display_player(_).
						
%states
get_state(Val):- state(Val).
					
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

				
%player move play
play_p1(XPlay,YPlay,Flower):- 
								get_state(STATE),
								STATE == 'end',
								print('Game has ended. Not allowed to play'),
								XPlay = XPlay, YPlay = YPlay, Flower = Flower.

play_p1(XPlay,YPlay,Flower):- 	
								get_state(STATE),
								STATE == 'p2',
								print('Player 2 or "S" turn'),
								XPlay = XPlay, YPlay = YPlay, Flower = Flower.
				
play_p1(XPlay,YPlay,Flower):-
								get_state(STATE),
								STATE == 'p1',
								
								get_player1(X,Y),
								get_list_of_plays(X,Y,List),
								
								check_if_valid_position(XPlay,YPlay,List,ValPosition),
								print(ValPosition), nl,
								
								check_if_flower_exists_p1(Flower, ValFlower),
								print(ValFlower).
				
				
%check if coords exsit in list of possible plays
check_if_valid_position(XPlay, YPlay, [], Val):- Val = 	'false',
														XPlay = XPlay, YPlay = YPlay.

check_if_valid_position(XPlay, YPlay, [P|Rest], Val):- 	
														check_point(XPlay,YPlay,P,Rest,Val).

check_point(XPlay,YPlay,[X | Y],Rest, Val):- 	
												X == XPlay, Y == YPlay, Val = 'true', Rest = Rest.
												
check_point(XPlay,YPlay,[X | Y],Rest, Val):-	X = X, Y = Y,
												check_if_valid_position(XPlay, YPlay, Rest, Val).
	


	
%check_if_flower_exists_p1
check_if_flower_exists_p1(Flower, ValFlower):- 	
												case_p1(CASE),
												exists_Flower(Flower, CASE, ValFlower).
												
exists_Flower(Flower, [], ValFlower):- 	Flower = Flower, ValFlower = 'false'.
exists_Flower(Flower, [FlowerN | _], ValFlower):- Flower == FlowerN, ValFlower = 'true'.	
exists_Flower(Flower, [_ | Rest], ValFlower):- exists_Flower(Flower, Rest, ValFlower).									

												
												
												
												