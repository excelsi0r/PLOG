case_player_default([]).

case_p1(_).
case_p2(_).

display_player(_):- nl.

display_p1_case(_):- 
						print('---------------------------------------------------------'), nl, print('P1: '),
						case_p1(CASEP1),
						print_case(CASEP1), nl,
						print('---------------------------------------------------------'), nl.
						
display_p2_case(_):-
						print('---------------------------------------------------------'), nl, print('P2: '),
						case_p2(CASEP2),
						print_case(CASEP2), nl,
						print('---------------------------------------------------------'), nl.

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