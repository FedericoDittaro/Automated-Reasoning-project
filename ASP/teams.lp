team(1..2).
position(1..5).

%%% Definizione dei giocatori
player(federico).
player(riccardo).
player(andrea).
player(alessandro).
player(stefano).
player(leonardo).
player(carlo).
player(matteo).
player(mattia).
player(kevin).

%%% Definizione delle altezze dei giocatori
height(federico, 178).
height(riccardo, 180).
height(andrea, 181).
height(alessandro, 190).
height(stefano, 198).
height(leonardo, 182).
height(carlo, 179).
height(matteo, 183).
height(mattia, 191).
height(kevin, 197).

%%% Definizione dei punteggi dei giocatori per ogni posizione
punteggio(federico, 1, 5).
punteggio(federico, 2, 4).
punteggio(federico, 3, 3).
punteggio(federico, 4, 2).
punteggio(federico, 5, 1).

punteggio(riccardo,1,4).
punteggio(riccardo,2,5).
punteggio(riccardo,3,3).
punteggio(riccardo,4,2).
punteggio(riccardo,5,1).

punteggio(andrea,1,3).
punteggio(andrea,2,4).
punteggio(andrea,3,5).
punteggio(andrea,4,2).
punteggio(andrea,5,1).

punteggio(alessandro,1,1).
punteggio(alessandro,2,2).
punteggio(alessandro,3,3).
punteggio(alessandro,4,5).
punteggio(alessandro,5,4).

punteggio(stefano,1,1).
punteggio(stefano,2,2).
punteggio(stefano,3,3).
punteggio(stefano,4,4).
punteggio(stefano,5,5).

punteggio(leonardo,1,5).
punteggio(leonardo,2,4).
punteggio(leonardo,3,3).
punteggio(leonardo,4,2).
punteggio(leonardo,5,1).

punteggio(carlo,1,4).
punteggio(carlo,2,5).
punteggio(carlo,3,3).
punteggio(carlo,4,2).
punteggio(carlo,5,1).

punteggio(matteo,1,3).
punteggio(matteo,2,4).
punteggio(matteo,3,5).
punteggio(matteo,4,2).
punteggio(matteo,5,1).

punteggio(mattia,1,1).
punteggio(mattia,2,2).
punteggio(mattia,3,3).
punteggio(mattia,4,5).
punteggio(mattia, 5,4).

punteggio(kevin,1,1).
punteggio(kevin,2,2).
punteggio(kevin,3,3).
punteggio(kevin,4,4).
punteggio(kevin,5,5).

%% Definizione dei giocatori che non possono stare nella stessa squadra
different_team(federico, riccardo).
different_team(andrea, matteo).

% Vincoli che creano squadre di esattamente 5 giocatori tutti diversi
1{team_created(T,G,P) : team(T), position(P)}1 :- player(G).
5{team_created(T,G,P) : player(G), position(P)}5 :- team(T).

% Ogni squadra ha un giocatore per ruolo
:- team_created(T, G1, P), team_created(T, G2, P), G1 != G2.

% Funzione per calcolare la somma delle altezze 
sum_heights(T, SUM) :- team(T), SUM = #sum{H : team_created(T, G, _), player(G), height(G,H)}.

% Vincolo sulle altezze dei giocatori 
:- team(T1), team(T2), T1 != T2, sum_heights(T1, X), sum_heights(T2, Y), X-Y > 19. 

% Verifica del vincolo different_team
:- team_created(T, G1, _), team_created(T, G2, _), different_team(G1, G2), G1 != G2.

% Calcolo della penalità
player_penalty(T, G, Pen) :- team(T), team_created(T, G, R), punteggio(G, R, S), Pen = 5-S.

penalty(P) :- P = #sum{Pen, G: player_penalty(_, G, Pen)}.

#minimize {P:penalty(P)}.
#show team_created/3.
#show sum_heights/2. 
#show penalty/1.