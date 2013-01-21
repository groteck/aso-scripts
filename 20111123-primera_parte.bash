#!/bin/bash
#vars for users information 
users=()
uids=()
names=()
#check arguments number
if [[ "$#" > "0" ]]; then
  # asign all arguments to users
  users=( $@ )
else
  #else asign al users with uid > 499 
  users=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "} $3 > 499 {print $1}'`)
fi
#create arrays with uids and names
for index in "${!users[@]}"
do
  uids[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "}{print $3}'`
  names[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "}{print $5}'`
done
# create fina strings for each user
for index in "${!users[@]}"
do
  full="${users[$index]} ${names[$index]} (${uids[$index]}):"
  groups=( `grep ${users[$index]} "/etc/group" | awk 'BEGIN {FS=":"} {print $1}'`)
  for group in "${groups[@]}"
  do
    full="$full $group"
  done
  echo "$full"
done
