# Analisi e realizzazione di codice Minizinc e ASP per la creazione di squadre di pallacanestro

Il problema assegnato prevede la creazione di squadre di pallacanestro a partire da una lista di giocatori p<sub>1<\sub>…p<sub>n</sub> in cui n è, per comodità, un multiplo di 5. 
Ogni giocatore assegna un punteggio da 1 a 5 alle possibili cinque posizioni (1 rappresenta il ruolo di point guard, 2 il ruolo di shooting guard, 3 il ruolo di small forward, 4 il 
ruolo di power forward e 5 il ruolo di centro) in cui 1 rappresenta il voto minimo (non vuole giocare in quel ruolo) e 5 il voto massimo (è il suo ruolo preferito). È inoltre 
presente una lista di “hard constraint” chiamata different_team(p<sub>i<\sub>, p<sub>j<\sub>) in cui viene specificata la coppia di giocatori che non possono stare nella stessa 
squadra. L’input del problema è quindi fornito dalle seguenti informazioni:
- Lista dei giocatori presenti;
- Altezza in centimetri dei giocatori;
- Punteggi assegnati da ogni giocatore ad ogni ruolo;
- Hard constraint.

L'obiettivo è quello di creare k squadre (dove k = n / 5) cercando di massimizzare le preferenze personali in modo tale che siano soddisfatti i seguenti vincoli:
1. Vincolo del ruolo: ogni squadra ha esattamente un giocatore per ruolo;
2. Vincole sulle altezze: sia t<sub>l<\sub> la somma delle altezze dei giocatori della squadra l, per ogni i, j appartenente a 1..k t<sub>i<\sub> - t<sub>j<\sub> $<$ 20;
3. Hard constraint: due giocatori inseriti nel predicato different_team non possono far parte delle stessa squadra;
4. Calcolo della penalità: la penalità viene calcolata per ogni giocatore la cui posizione in squadra non è la sua preferita (ovvero quella a cui ha assegnato il punteggio 5), se
ad esempio il ruolo preferito di un giocatore è il centro, ma viene assegnato ad un’altra posizione, allora la penalità sarà 5 - X dove X rappresenta il punteggio assegnato alla
posizione corrispondente. L’obiettivo è quello di minimizzare la penalità.
