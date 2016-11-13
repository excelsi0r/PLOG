:-include('board.pl').
:-include('players.pl').

:- 	dynamic
	state/1.

state(_).

%To play the game
start(_):- 	

					write('Welcome to the Gardens of IO.'), nl,
					write('Available types: '),nl,nl,
					write('  "pp"     - Player VS Player'), nl,
					write('  "greedy" - Player VS Greedy Computer'),nl,
					write('  "easy"   - Player VS Easy Computer'),nl,
					write('  "cc"     - Computer VS Computer'),nl,nl,
					write('Type: '),
					read(A),
					start_game(A).

start_game(TYPE):- 
					TYPE == 'pp',					
					initialize(_),
					display_game(_),
					cycle_pp(_).
				
start_game(TYPE):-
					TYPE == 'greedy',			
					initialize(_),
					display_game(_),		
					start_greedy(_).

start_game(TYPE):-	
					TYPE == 'easy',
					initialize(_),
					display_game(_),		
					start_easy(_).
				
start_game(TYPE):-	
					TYPE == 'cc',
					initialize(_),
					display_game(_),		
					start_cc(_).

start_game(_):- 	print('Invalid Game Type'), nl.
				
				
cycle_pp(_):- 	
				get_state(STATE), 		
				process_pp(STATE).

process_pp(STATE):-		STATE \= 'end',
						play_cc(_),
						cycle_pp(_).
						
process_pp(_).

				



				
							
					
					
start_greedy(_).
start_easy(_).	
start_cc(_).

%convert flower to number
convert_flower_number(F, FN):- 	F == 'w', FN is 1.
convert_flower_number(F, FN):- 	F == 'y', FN is 2.
convert_flower_number(F, FN):- 	F == 'g', FN is 3.
convert_flower_number(F, FN):- 	F == 'b', FN is 4.
convert_flower_number(F, FN):- 	F == 'p', FN is 5.
convert_flower_number(F, FN):- 	F == 'r', FN is 6.
convert_flower_number(_, FN):- 	FN is -1.
							
%initialize
initialize(_):- 	

				%set loading/start state 
				set_state_end(_),
				set_state_start(_),
				
				
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
				set_state_p1(_).

%display	
display_game(_):- 	print_state(_),
					display_table(_),
					display_p1_case(_),
					display_p1_score(_),
					nl,
					display_p2_case(_),
					display_p2_score(_).		

%play CC
play_cc(_):- 						
							write('Insert New X coordinate:'), read(X),
							write('Insert New Y coordinate:'), read(Y),
							write('Insert New Flower (y, w, r, p, b, g):'), read(F),
							
							convert_flower_number(F, Flower),
							
							
							X1 is X + 2, Y1 is Y + 2,
							print(X1), print(' '), print(Y1), print(' '), print(Flower),nl.
							

	
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
								
								get_player1(X,Y,PlayerStat),
								
								get_list_of_plays(X,Y,List),	
								
								get_player2(_,_, P2),
								
								
								check_if_valid_position(XPlay,YPlay,List,ValPosition),
								print(ValPosition), nl,
								
								check_if_flower_exists_p1(Flower, ValFlower),
								print(ValFlower),
								
								delete_flower_p1(Flower),
								place_elem_table(XPlay, YPlay, Flower),
								
								
								calculate_score(XPlay, YPlay, Flower, Scorelist),
								length(Scorelist, Score),
								update_score_p1(X, Y, PlayerStat, Score, P2),
								
								check_scores_and_set_state(Flower).							
				
%================================================================================================				
%states
get_state(Val):- state(Val).

set_state_end(_):- asserta(state('end')).					
set_state_start(_):- asserta(state('start')).
set_state_p1(_):- asserta(state('p1')).
set_state_p2(_):- asserta(state('p2')).



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


check_scores_and_set_state(Flower):- 	set_state_p2(_),
										check_if_flower_exists_p1(Flower, ValP1),
										check_if_flower_exists_p2(Flower, ValP2),
										
										score_p1(ScoreP1),
										score_p2(ScoreP2),
										
										Diff is ScoreP1 - ScoreP2,
										Val is abs(Diff),
										
										check_flower_and_score(ValP1, ValP2, Val).
										
check_flower_and_score(ValP1, ValP2, _):- 	ValP1 == 'false', ValP2 = 'false',
												set_state_end(_).
															
check_flower_and_score(_, _, Diff):- 	
												Diff >= 39,
												set_state_end(_).
												
check_flower_and_score(_, _,_).
										
										
										
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
												
check_if_flower_exists_p2(Flower, ValFlower):- 	
												case_p2(CASE),
												exists_Flower(Flower, CASE, ValFlower).
												
exists_Flower(Flower, [], ValFlower):- 	Flower = Flower, ValFlower = 'false'.
exists_Flower(Flower, [FlowerN | _], ValFlower):- Flower == FlowerN, ValFlower = 'true'.	
exists_Flower(Flower, [_ | Rest], ValFlower):- exists_Flower(Flower, Rest, ValFlower).	

%caculate score of play
calculate_score(XPlay, YPlay, Flower, Score):- 		calculate_arround(XPlay, YPlay, Flower, Score).

															
															
calculate_arround(XPlay, YPlay, Flower, Scoretemp):-
																caculate_left(XPlay, YPlay, Flower, Score1),
																caculate_right(XPlay, YPlay, Flower, Score2),
																caculate_up(XPlay, YPlay, Flower, Score3),
																caculate_down(XPlay, YPlay, Flower, Score4),
																
																
																append(Score1, Score2, Scoretemp1),
																append(Scoretemp1, Score3, Scoretemp2),
																append(Scoretemp2, Score4, Scoretemp3),
																
																append(Scoretemp3, [1], Scoretemp).
															
%search left																										
caculate_left(X, Y, Flower, Scoretemp):-	
												X > 1, X < 11,
												Y > 1, Y < 11,
												
												XNew is X - 1,
												
												XNew > 1,

												get_elem(XNew, Y, Elem),
												next_left(XNew, Y, Flower, Elem, Scoretemp).
										
caculate_left(X, Y, Flower, Scoretemp):- 		List1 = [],
												append(List1, [], Scoretemp),
												X = X, Y = Y, Flower = Flower, Scoretemp = Scoretemp.
										
next_left(X, Y, Flower,Elem, Scoretemp):-		
												Flower == Elem, 												
												caculate_left(X, Y, Flower, List1),
												append(List1, [1], Scoretemp).
																	
next_left(X, Y, Flower,Elem, Scoretemp):- 	List1 = [],
											append(List1,  [], Scoretemp),
											X = X, Y = Y, Flower = Flower, Elem = Elem, Scoretemp = Scoretemp.
											
%caculate_rigth
caculate_right(X, Y, Flower, Scoretemp):-	
												X > 1, X < 11,
												Y > 1, Y < 11,
												
												XNew is X + 1,
												
												XNew < 11,

												get_elem(XNew, Y, Elem),
												next_right(XNew, Y, Flower, Elem, Scoretemp).
										
caculate_right(X, Y, Flower, Scoretemp):- 		List1 = [],
												append(List1, [], Scoretemp),
												X = X, Y = Y, Flower = Flower, Scoretemp = Scoretemp.
										
next_right(X, Y, Flower,Elem, Scoretemp):-		
												Flower == Elem, 												
												caculate_right(X, Y, Flower, List1),
												append(List1, [1], Scoretemp).
																	
next_right(X, Y, Flower,Elem, Scoretemp):- 	List1 = [],
											append(List1,  [], Scoretemp),
											X = X, Y = Y, Flower = Flower, Elem = Elem, Scoretemp = Scoretemp.
											
%caculate_down
caculate_down(X, Y, Flower, Scoretemp):-	
												X > 1, X < 11,
												Y > 1, Y < 11,
												
												YNew is Y + 1,
												
												YNew < 11,

												get_elem(X, YNew, Elem),
												next_down(X, YNew, Flower, Elem, Scoretemp).
										
caculate_down(X, Y, Flower, Scoretemp):- 		List1 = [],
												append(List1, [], Scoretemp),
												X = X, Y = Y, Flower = Flower, Scoretemp = Scoretemp.
										
next_down(X, Y, Flower,Elem, Scoretemp):-		
												Flower == Elem, 												
												caculate_down(X, Y, Flower, List1),
												append(List1, [1], Scoretemp).
																	
next_down(X, Y, Flower,Elem, Scoretemp):- 	List1 = [],
											append(List1,  [], Scoretemp),
											X = X, Y = Y, Flower = Flower, Elem = Elem, Scoretemp = Scoretemp.
											
%caculate_up
caculate_up(X, Y, Flower, Scoretemp):-	
												X > 1, X < 11,
												Y > 1, Y < 11,
												
												YNew is Y - 1,
												
												YNew > 1,

												get_elem(X ,YNew, Elem),
												next_up(X, YNew, Flower, Elem, Scoretemp).
										
caculate_up(X, Y, Flower, Scoretemp):- 			List1 = [],
												append(List1, [], Scoretemp),
												X = X, Y = Y, Flower = Flower, Scoretemp = Scoretemp.
										
next_up(X, Y, Flower,Elem, Scoretemp):-		
												Flower == Elem, 												
												caculate_up(X, Y, Flower, List1),
												append(List1, [1], Scoretemp).
																	
next_up(X, Y, Flower,Elem, Scoretemp):- 	List1 = [],
											append(List1,  [], Scoretemp),
											X = X, Y = Y, Flower = Flower, Elem = Elem, Scoretemp = Scoretemp.
											
											
											
%update score player 1
update_score_p1(X,Y,PlayerStat, Score, P2):- 
												P2Score is P2 - 200,
												P1Score is PlayerStat - 100,												
												NextScore is P1Score + Score,											
												place_elem_table(X, Y, P1Score),												
												score_p1(SCORE),
												NewScore is SCORE + Score,
												asserta(score_p1(NewScore)),											
												move_p1(P1Score, NextScore, P2Score).
												
											
move_p1(P1Place, NextP1Place, P2Place):- 		P1Place < P2Place, NextP1Place >= P2Place,
												NewPlace is NextP1Place + 1,												
												assert_place_p1(NewPlace).
												
											
move_p1(P1Place, NextP1Place, P2Place):-	
												P1Place = P1Place,
												NextP1Place > 49,
												N is NextP1Place - 50,
												NewPlace is N + 10,		
												NewPlace >= P2Place,												
												N1 is NewPlace + 1,	
												assert_place_p1(N1).
												
											
move_p1(P1Place, NextP1Place, P2Place):-		P1Place = P1Place,
												NextP1Place > 49,
												N is NextP1Place - 50,
												NewPlace is N + 10,												
												NewPlace < P2Place,									
												assert_place_p1(NewPlace).
												
move_p1(_, NextP1Place, _):-		assert_place_p1(NextP1Place).

assert_place_p1(NewPlace):- 		
										NewPlace > 49,
										Nindex is NewPlace - 50,										
										N is Nindex + 10,
										get_coords_elem(X, Y, N),
										Player is N + 100,
										place_elem_table(X, Y, Player).
										
										
assert_place_p1(NewPlace):-				get_coords_elem(X, Y, NewPlace),
										Player is NewPlace + 100,
										place_elem_table(X, Y, Player).							
							
										
											
												
							

												
												
												
												