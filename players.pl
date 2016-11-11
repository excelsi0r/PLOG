:- 	dynamic
	case_p1/1,
	case_p2/1,
	score_p1/1,
	score_p2/1.

case_player_default([]).
score_player_default(0).

case_p1(_).
case_p2(_).

score_p1(_).
score_p2(_).

display_player(_):- nl.

reset_players(_):- 
					case_player_default(DEFCASEPLAYER),
					asserta(case_p1(DEFCASEPLAYER)),
					asserta(case_p2(DEFCASEPLAYER)),
					score_player_default(DEFSCOREPLAYER),
					asserta(score_p1(DEFSCOREPLAYER)),
					asserta(score_p2(DEFSCOREPLAYER)).


display_p1_case(_):- 
						print('---------------------------------------------------------'), nl, print('P1: '),
						case_p1(CASEP1),
						print_case(CASEP1), nl,
						print('---------------------------------------------------------'),nl.
						
display_p2_case(_):-
						print('---------------------------------------------------------'), nl, print('P2: '),
						case_p2(CASEP2),
						print_case(CASEP2), nl,
						print('---------------------------------------------------------'),nl.
						
display_p1_score(_):-
						score_p1(P1),
						print('Score: '), 
						print(P1),
						nl.
						
display_p2_score(_):-
						score_p2(P2),
						print('Score: '), 
						print(P2),
						nl.
						
delete_flower_p1(Flower):- 	case_p1(CASE),
							select(Flower, CASE, List),
							asserta(case_p1(List)).
							
delete_flower_p2(Flower):- 	case_p2(CASE),
							select(Flower, CASE, List),
							asserta(case_p1(List)).

print_case([]).
print_case([Elem | Rest]):- 
								print_elem_case(Elem), print(' '),
								print_case(Rest).
								
print_elem_case(Cell):- Cell == 1, print('w').
print_elem_case(Cell):- Cell == 2, print('y').
print_elem_case(Cell):- Cell == 3, print('g').
print_elem_case(Cell):- Cell == 4, print('b').
print_elem_case(Cell):- Cell == 5, print('p').
print_elem_case(Cell):- Cell == 6, print('r').