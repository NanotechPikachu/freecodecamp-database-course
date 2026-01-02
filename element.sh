PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  QUERY=$($PSQL "select name, properties.atomic_number, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol ilike '$1' or name ilike '$1' or properties.atomic_number::text ilike '$1'")
  if [[ -z $QUERY ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read NAME NUMBER SYMBOL MASS MPOINT BPOINT TYPE <<< "$QUERY"
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPOINT celsius and a boiling point of $BPOINT celsius."
  fi
fi