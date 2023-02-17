%*******************************************************************************
%                                    AETOILE
%*******************************************************************************

/*
Rappels sur l'algorithme
 
- structures de donnees principales = 2 ensembles : P (etat pendants) et Q (etats clos)
- P est dedouble en 2 arbres binaires de recherche equilibres (AVL) : Pf et Pu
 
   Pf est l'ensemble des etats pendants (pending states), ordonnes selon
   f croissante (h croissante en cas d'egalite de f). Il permet de trouver
   rapidement le prochain etat a developper (celui qui a f(U) minimum).
   
   Pu est le meme ensemble mais ordonne lexicographiquement (selon la donnee de
   l'etat). Il permet de retrouver facilement n'importe quel etat pendant

   On gere les 2 ensembles de fa�on synchronisee : chaque fois qu'on modifie
   (ajout ou retrait d'un etat dans Pf) on fait la meme chose dans Pu.

   Q est l'ensemble des etats deja developpes. Comme Pu, il permet de retrouver
   facilement un etat par la donnee de sa situation.
   Q est modelise par un seul arbre binaire de recherche equilibre.

Predicat principal de l'algorithme :

   aetoile(Pf,Pu,Q)

   - reussit si Pf est vide ou bien contient un etat minimum terminal
   - sinon on prend un etat minimum U, on genere chaque successeur S et les valeurs g(S) et h(S)
	 et pour chacun
		si S appartient a Q, on l'oublie
		si S appartient a Ps (etat deja rencontre), on compare
			g(S)+h(S) avec la valeur deja calculee pour f(S)
			si g(S)+h(S) < f(S) on reclasse S dans Pf avec les nouvelles valeurs
				g et f 
			sinon on ne touche pas a Pf
		si S est entierement nouveau on l'insere dans Pf et dans Ps
	- appelle recursivement etoile avec les nouvelles valeurs NewPF, NewPs, NewQs

*/

%*******************************************************************************

:- ['avl.pl'].       % predicats pour gerer des arbres bin. de recherche   
:- ['taquin.pl'].    % predicats definissant le systeme a etudier

%*******************************************************************************

expend(N,S):-                                                       /*N pour Noeud de pu  et pour Successeur de type pu */
N=[Etat_u,[F,H,G],_Pere,_Action],                       /*On dit ce à quiu N ressemble*/

    findall( [E_Suiv,[F_Suiv,H_Suiv,G_Suiv],Etat_u,AS],                                                   /*E : Etat     ,ici le pere est l'etat u',  AS :Action pour aller à Successeur */
        (rule( AS,  Cost  ,   Etat_u , E_Suiv     ) ,
        heuristique(E_Suiv,H_Suiv),
        G_Suiv is G + Cost,
        F_Suiv is H_Suiv + G_Suiv
        ),
    S).                                                                                /*S : Liste Successeurs */

%affiche_solution():- true.

%loop_successors():- true.


main :-
	initial_state(Ini),
    G_0 is 0,
    heuristique(Ini,H_0),
    F_0 is G_0 + H_0,
    empty(Pf),
    empty(Pu),
    empty(Q),
    insert([[F_0,H_0,G_0],Ini],Pf,Pf1),
    insert([Ini,[F_0,H_0,G_0],nil,nil],Pu,Pu1 ),                                /* Avec predecessuer et action qui mène au successuer*/
    aetoile(Pf,Pu,Q).



%*******************************************************************************

aetoile(Pf, Ps, Qs) :-
	true.   %********
			% A FAIRE
			%********
	

	
   