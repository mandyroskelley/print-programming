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
female(brenda).
female(krista).
female(kaitlyn).

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
male(ray).
male(tony).

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
child(marge,brenda).
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
child(steven,krista).
child(steven,tony).
child(krista,kaitlyn).
child(kathie, amy).
child(mandy, emma).
child(mandy, preston).
child(mandy, brecken).
child(michael, isabella).
child(michael, vinady).
child(jerryS, briana).
child(jerryS, melissa).
child(brenda,ray).
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

parents(X,Y):-
	child(X,W),
	child(Y,W),
	X \== Y,
	!.

greatgrandmother(X,Y) :-
	child(X,W),
	child(W,Z),
	child(Z,Y),
	female(X).

greatgrandfather(X,Y) :-
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

bothMomAndDad(X) :-
	mother(Z,X),
	father(W,X),
	parents(W,Z).

sister(X,Y) :-
	bothMomAndDad(X),
	mother(Z,X),
	mother(Z,Y),
	female(X),
	X \== Y.

sister(X,Y) :-
	\+ bothMomAndDad(X),
	child(Z,X),
	child(Z,Y),
	female(X),
	X \== Y.	

brother(X,Y) :-
	bothMomAndDad(X),
	mother(Z,X),
	mother(Z,Y),
	male(X),
	X \== Y.

brother(X,Y) :-
	\+ bothMomAndDad(X),
	child(Z,X),
	child(Z,Y),
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

niece(X,Y) :-
	uncle(Y,X),
	female(X).

niece(X,Y) :-
	aunt(Y,X),
	female(X).

nephew(X,Y) :-
	uncle(Y,X),
	male(X).

nephew(X,Y) :-
	aunt(Y,X),
	male(X).	

cousin(X,1,Y) :-
	uncle(Z,X),
	child(Z,Y).

cousin(X,1,Y):-
	aunt(Z,X),
	child(Z,Y).

cousin(X,2,Y) :-
	cousinRemoved(X,1,1,up,Z),
	child(Z,Y).	

cousin(X,3,Y) :-
	cousinRemoved(X,2,1,up,Z),
	child(Z,Y).

cousinRemoved(X,1,1,up,Y) :-
	mother(Z,X),
	cousin(Z,1,Y).

cousinRemoved(X,1,1,up,Y) :-
	father(Z,X),
	cousin(Z,1,Y).	

cousinRemoved(X,1,1,down,Y) :-
	cousin(X,1,Z),
	child(Z,Y).

cousinRemoved(X,1,2,up,Y) :-
	grandmother(Z,X),
	cousin(Z,1,V),
	child(V,Y).

cousinRemoved(X,2,1,down,Y) :-
	cousin(X,2,Z),
	child(Z,Y).

cousinRemoved(X,2,1,up,Y) :-
	cousinRemoved(X,1,2,up,Z),
	child(Z,Y).

all_cousins(Person,Degree,ListOfCousins):-
	findall(Y,cousin(Person,Degree,Y),ListOfCousins).

all_cousinsRemoved(Person,Degree,RemovedNumber,RemovedDirection,ListOfCousins) :-
	findall(Y,cousinRemoved(Person,Degree,RemovedNumber,RemovedDirection,Y),ListOfCousins).

isSingleChild(X) :-
	\+ brother(X,_),
	\+ sister(X,_),
	!.
