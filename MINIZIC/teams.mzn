include "globals.mzn";

% Definizione delle squadre
int: maxt = 2;

% Definizione dei giocatori
int: maxp = 10;
array[1..maxp] of string: playersNames = ["federico", "riccardo", "andrea", "alessandro", "stefano", "leonardo", "carlo", "matteo", "mattia",
                                          "kevin"];
                                                            

% Definizione delle altezze
array[1..maxp] of int: playersHeights = [178, 180, 181, 190, 198, 182, 179, 183, 191, 197];

% Definizione dei punteggi
array[1..maxp, 1..5] of int: playersScores = array2d(1..maxp, 1..5, [
    5, 4, 3, 2, 1,  % federico
    4, 5, 3, 2, 1,  % riccardo
    3, 4, 5, 2, 1,  % andrea
    1, 2, 3, 5, 4,  % alessandro
    1, 2, 3, 4, 5,  % stefano
    5, 4, 3, 2, 1,  % leonardo
    4, 5, 3, 2, 1,  % carlo
    3, 4, 5, 2, 1,  % matteo
    1, 2, 3, 5, 4,  % mattia
    1, 2, 3, 4, 5  % kevin
]);

% Definizione different_team (1 non possono stare nella stessa squadra, 0 si)
% In questo caso (Federico, Riccardo) e (Andrea, Matteo)
array[1..maxp, 1..maxp] of 0..1: different_team = array2d(1..maxp, 1..maxp, [
    0, 1, 0, 0, 0, 0, 0, 0, 0, 0,  % federico
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % riccardo
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0,  % andrea
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % alessandro
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % stefano
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % leonardo
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % carlo
    0, 0, 1, 0, 0, 0, 0, 0, 0, 0,  % matteo
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  % mattia
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0   % kevin
]);

% Array contente le squadre
array[1..maxp] of var 1..maxt: team_created;

% constraint team_created[1] = 2;

% Array contenente i ruoli dei giocatori
array[1..maxp] of var 1..5: players_roles;

% Ogni squadra ha esattamente 5 giocatori
constraint forall(t in 1..maxt) (
    count(team_created, t, 5)
);

% Ogni squadra ha esattamente un giocatore per ruolo
constraint forall(t in 1..maxt) (
    forall(i, j in 1..maxp where team_created[i] = t /\ team_created[j] = t /\ i != j) (
     players_roles[i] != players_roles[j]
  )
);

% Vincolo sulle altezze dei giocatori
constraint forall(t, k in 1..maxt where t != k) (
          let{
            var int: sum1 = sum(i in 1..maxp where team_created[i] = t)(playersHeights[i]),
            var int: sum2 = sum(j in 1..maxp where team_created[j] = k)(playersHeights[j])
          } in
          abs(sum1-sum2) < 20
);

% Verifica del vincolo different_team
constraint forall(t in 1..maxt) (
      forall(i, j in 1..maxp where team_created[i] = t /\ team_created[j] = t /\ i != j) (
          different_team[i, j] != 1 /\ different_team[j, i] != 1
      )
);


% Calcolo della penalità
var int: sum_votes = sum(i in 1..maxp, t in 1..maxt where team_created[i] = t)(
    playersScores[i, players_roles[i]]
);

var int: penalty = 25*maxt - sum_votes;

solve minimize penalty;

% Output
output["Squadra: " ++ show(team_created) ++ "\n" ++ 
       "Ruoli:   " ++ show(players_roles) ++ "\n" ++
       "Penalità: "  ++ show(penalty)];