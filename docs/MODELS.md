# Models

## Group

Un groupe possède :
- un nom

## Idol

Un(e) idol possède :
- un nom
- un groupe

## Theme

Un thème possède :
- un nom
- un booléen "Special"
  - définit des règles comme pour le thème Winter 2020
    - IV 10 only
- des idols
  - via une association HABTM

Note : Les groupes sont déduits via les idols

## Card

Une carte possède :
- Un(e) idol
- Un thème
- Un code unique
- Un nombre d'IV
- Un rang (C, B, A, S, R)
- Un niveau (1-5 jusqu'à S puis 1-99 en R)
