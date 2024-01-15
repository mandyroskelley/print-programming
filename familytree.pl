female(mandy).
female(cindy).
female(emma).
female(rose).
female(mary).
female(isabella).
female(vinady).
female(kathie).
female(amy).
female(rachel).
female(marge).
female(briana).
female(melissa).
female(ella).
female(june).
female(charlotte).
female(susan).
female(gail).
female(carrie).
female(elizabeth).
female(joann).
female(noelle).
female(jenny).
female(maryann).
female(ayla).

male(michael).
male(jerry).
male(preston).
male(brecken).
male(louis).
male(james).
male(steven).
male(mike).
male(jerryS).
male(bob).
male(carson).
male(john).
male(charles).
male(earl).
male(mark).
male(robert).
male(caleb).
male(jake).
male(mikey).
male(thomas).
male(colton).

child(charlotte, june).
child(charlotte, susan).
child(john, june).
child(john, susan).
child(susan, earl).
child(susan, gail).
child(charles, earl).
child(charles, gail).
child(earl, mark).
child(earl, robert).
child(carrie, mark).
child(carrie, robert).
child(bob, rose).
child(bob, marge).
child(june, rose).
child(june, marge).
child(mark, elizabeth).
child(mark, maryanne).
child(elizabeth, scott).
child(elizabeth,thomas).
child(thomas, scott).
child(rose, cindy).
child(rose, kathie).
child(rose, steven).
child(louis, cindy).
child(louis, kathie).
child(louis, steven).
child(marge, jerryS).
child(wes, jerryS).
child(mary, jerry).
child(mary, mike).
child(james, jerry).
child(james, mike).
child(mary, joann).
child(james, joann).
child(jerry, mandy).
child(jerry, michael).
child(cindy, mandy).
child(cindy, michael).
child(kathie, amy).
child(mandy, emma).
child(mandy, preston).
child(mandy, brecken).
child(michael, isabella).
child(michael, vinady).
child(jerryS, briana).
child(jerryS, melissa).
child(mike, rachel).
child(joann,jenny).
child(joann,mikey).
child(jenny, ayla).
child(rachel, carson).
child(rachel, colton).
child(briana, ella).
child(briana, noelle).
child(briana, caleb).
child(briana, jake).

person(X) :- male(X).
person(X) :- female(X).

married(X,Y) :-
	child(X,Z),
	child(Y,Z),
	!.

greatgrandmother(X,Y) :-
	child(X,W),
	child(W,Z),
	child(Z,Y),
	female(X).

greatgrandmother(X,Y) :-
	child(X,W),
	child(W,Z),
	child(Z,Y),
	male(X).

grandmother(X,Y) :-
	child(X,Z),
	child(Z,Y),
	female(X).

grandfather(X,Y) :-
	child(X,Z),
	child(Z,Y),
	male(X).

mother(X,Y) :- 
	child(X,Y),
	female(X).

father(X,Y) :-
	child(X,Y),
	male(X).

sister(X,Y) :-
	mother(Z,X),
	mother(Z,Y),
	father(V,X),
	father(V,Y),
	female(X),
	X \== Y.

brother(X,Y) :-
	mother(Z,X),
	mother(Z,Y),
	father(V,X),
	father(V,Y),
	male(X),
	X \== Y.

greataunt(X,Y) :-
	sister(X,Z),
	grandmother(Z,Y).

greataunt(X,Y) :-
	sister(X,Z),
	grandfather(Z,Y).

greatuncle(X,Y) :-
	brother(X,Z),
	grandmother(Z,Y).

greatuncle(X,Y) :-
	brother(X,Z),
	grandfather(Z,Y).

aunt(X,Y) :-
	sister(X,Z),
	child(Z,Y),
	female(X),
	Y \== Z.

uncle(X,Y) :-
	brother(X,Z),
	child(Z,Y),
	male(X),
	Y \== Z.

cousin(X,Y,1) 

cousin1(X,Y):-
	uncle(Z,X),
	child(Z,Y).

cousin1(X,Y):-
	aunt(Z,X),
	child(Z,Y).

cousin1onceRem(X,Y) :-
	mother(Z,X),
	cousin1(Z,Y).

cousin1onceRem(X,Y) :-
	father(Z,X),
	cousin1(Z,Y).	

cousin1onceRem(X,Y) :-
	cousin1(X,Z),
	child(Z,Y).

cousin1twiceRem(X,Y) :-
	grandmother(Z,X),
	cousin1(Z,V),
	child(V,Y).

cousin2(X,Y) :-
	cousin1onceRem(X,Z),
	child(Z,Y).

cousin2onceRem(X,Y) :-
	cousin2(X,Z),
	child(Z,Y).

cousin2onceRem(X,Y) :-
	cousin1twiceRem(X,Z),
	child(Z,Y).

cousin3(X,Y) :-
	cousin2onceRem(X,Z),
	child(Z,Y).

all_cousins(Person,Degree,ListOfCousins) :-
	findall(Y,cousin1(X,Y),listOfCousin1).


all_cousins(X,2,listOfCousins) :-
	cousin2(X,Y),
	listOfCousins([Y]).

all_cousins(X,3,listOfCousins) :-
	cousin3(X,Y),
	listOfCousins([Y]).

all_cousinsRemoved(X,1,1,up,listOfCousins) :-
	cousin1onceRem(X,Y),
	child(Z,X),
	cousin1(Z,Y),
	listOfCousins([Y]).

all_cousinsRemoved(X,1,1,down,listOfCousins) :-
	cousin1onceRem(X,Y),
	child(Z,Y),
	cousin1(X,Z),
	listOfCousins([Y]).	

all_cousinsRemoved(X,2,1,up,listOfCousins) :-
	cousin2onceRem(X,Y),
	child(Z,X),
	cousin2(Z,Y),
	listOfCousins([Y]).

all_cousinsRemoved(X,2,1,down,listOfCousins) :-
	cousin2onceRem(X,Y),
	child(Z,Y),
	cousin2(X,Z),
	listOfCousins([Y]).	

all_cousinsRemoved(X,2,2,up,listOfCousins) :-
	cousin2twiceRem(X,Y),
	child(Z,Y),
	cousin2(X,Z),
	listOfCousins([Y]).	

all_cousinsRemoved(X,2,2,down,listOfCousins) :-
	cousin2twiceRem(X,Y),
	child(Z,Y),
	cousin2(X,Z),
	listOfCousins([Y]).

isSingleChild(X) :-
	\+ brother(X,_),
	\+ sister(X,_),
	!.

add(X,[H|T],[H|R]) :-
	add(X,R,T).
add(X,[],[X]).

printList([]):- write('**End of list**'), nl.
printList([H|T]) :-
	write(H), nl,
	printList(T).

