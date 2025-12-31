#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WGOALS OGOALS
do
  if [[ $YEAR != 'year' ]]
  then
    QUERY1=$($PSQL "select * from teams where name='$WINNER'")
    QUERY2=$($PSQL "select * from teams where name='$OPPONENT'")
    if [[ -z $QUERY1 ]]
    then
      CMD=$($PSQL "insert into teams(name) values('$WINNER')")
    elif [[ -z $QUERY2 ]]
    then
      CMD=$($PSQL "insert into teams(name) values('$OPPONENT')")
    elif [[ -z $QUERY1 && -z $QUERY2 ]]
    then
      CMD=$($PSQL "insert into teams(name) values('$WINNER'), ('$OPPONENT')")
    fi
  fi
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WGOALS OGOALS
do
  if [[ $YEAR != 'year' ]]
  then
    WID=$($PSQL "select team_id from teams where name='$WINNER'")
    OID=$($PSQL "select team_id from teams where name='$OPPONENT'")
    CMD=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WID, $OID, $WGOALS, $OGOALS)")
  fi
done