#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Program that outputs information about elements

# if no provided argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# get element info
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1")
ELEMENT_NAME=$($PSQL "SELECT name FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")

# if argument is not 1 of the 3
if [[ $1 && -z $ATOMIC_NUMBER && -z $ELEMENT_NAME && -z $ELEMENT_SYMBOL ]]
then
  echo "I could not find that element in the database."
else

  # if argument is an atomic number
  if [[ $ATOMIC_NUMBER ]]
  then
    ELEMENT_NAME=$($PSQL "SELECT name FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number='$1'")
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  
  # if argument is a name
  elif [[ $ELEMENT_NAME ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  
  # if argument is a symbol
  elif [[ $ELEMENT_SYMBOL ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    ELEMENT_NAME=$($PSQL "SELECT name FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi