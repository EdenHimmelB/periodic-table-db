#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
PERIODIC_TABLE() {
  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  else
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo I could not find that element in the database.
      else
        SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//')
        NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//')
        TYPE=$(echo $($PSQL "SELECT type FROM properties p JOIN types t ON p.type_id = t.type_id WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//')
        MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//')
        MELT_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//') 
        BOIL_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1") | sed -e 's/^[[:space:]]*//')
        echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
      fi
    else
      SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'") | sed -e 's/^[[:space:]]*//')
      if [[ -z $SYMBOL ]]
      then
        NAME=$(echo $($PSQL "SELECT name FROM elements WHERE name = '$1'") | sed -e 's/^[[:space:]]*//')
        if [[ -z $NAME ]]
        then
          echo I could not find that element in the database.
        else
        ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'") | sed -e 's/^[[:space:]]*//')
        SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        TYPE=$(echo $($PSQL "SELECT type FROM properties p JOIN types t ON p.type_id = t.type_id WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        MELT_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//') 
        BOIL_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
        fi
      else
        ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'") | sed -e 's/^[[:space:]]*//')
        NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        TYPE=$(echo $($PSQL "SELECT type FROM properties p JOIN types t ON p.type_id = t.type_id WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        MELT_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//') 
        BOIL_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER") | sed -e 's/^[[:space:]]*//')
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
      fi
    fi
  fi
}

PERIODIC_TABLE $1