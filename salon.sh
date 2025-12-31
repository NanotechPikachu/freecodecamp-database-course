#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only --no-align -c"

SERVICES=$($PSQL "select service_id, name from services")
echo -e "\n~~~~~ MY SALON ~~~~~"

SERVICES_MENU() {
  echo -e "\nServices:\n"
  echo "$SERVICES" | while IFS="|" read SID NAME
  do
    echo "$SID) $NAME"
  done
}

MAIN() {
  SERVICES_MENU

  read SERVICE_ID_SELECTED
  CHOICE_AVAIL=$($PSQL "select name from services where service_id='$SERVICE_ID_SELECTED'")
  if [[ -z $CHOICE_AVAIL ]]
  then
    SERVICES_MENU
  else
    echo -e "\nEnter phone"
    read CUSTOMER_PHONE
    CUSTOMER=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER ]]
    then
      echo -e "\nEnter name"
      read CUSTOMER_NAME
      ADD=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
    CUSTOMER=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
    echo -e "\nEnter time"
    read SERVICE_TIME
    APPOINT=$($PSQL "insert into appointments(customer_id, service_id, time) values($CUSTOMER, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")
    CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER")
    
    echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."

  fi

}

MAIN