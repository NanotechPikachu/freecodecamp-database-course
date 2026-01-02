#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

TRIES=0
GUESS=0
echo "Enter your username:"
read USERNAME
USER=$($PSQL "select username, guesses, played from guess where username='$USERNAME'")
NUMBER=$(( (RANDOM % 1000) + 1 ))
if [[ -z $USER ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  echo "Guess the secret number between 1 and 1000:"
  while [[ $GUESS != $NUMBER ]]
  do
    read GUESS
    if [[ $GUESS =~ ^[0-9]+$ ]]
    then
      TRIES=$(( TRIES + 1 ))
      if [[ $GUESS -lt $NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      elif [[ $GUESS -gt $NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      fi
    else
      echo "That is not an integer, guess again:"
    fi
  done
  echo "You guessed it in $TRIES tries. The secret number was $NUMBER. Nice job!"
  INST=$($PSQL "insert into guess(username, guesses, played) values('$USERNAME', $TRIES, 1)")

else
  IFS="|" read USERNAME GUESSES PLAYED <<< "$USER"
  echo "Welcome back, $USERNAME! You have played $PLAYED games, and your best game took $GUESSES guesses."
  echo "Guess the secret number between 1 and 1000:"
  while [[ $GUESS != $NUMBER ]]
  do
    read GUESS
    if [[ $GUESS =~ ^[0-9]+$ ]]
    then
      TRIES=$(( TRIES + 1 ))
      if [[ $GUESS -lt $NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      elif [[ $GUESS -gt $NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      fi
    else
      echo "That is not an integer, guess again:"
    fi
  done
  echo "You guessed it in $TRIES tries. The secret number was $NUMBER. Nice job!"
  QRY=""
  if [[ $GUESSES -lt $TRIES ]]
  then
    QRY="update guess set played=played+1 where username='$USERNAME'"
  else
    QRY="update guess set played=played+1, guesses=$TRIES where username='$USERNAME'"
  fi
  UPDT=$($PSQL "$QRY")
fi