#!/bin/bash
users=()
uids=()
names=()
if [[ "$#" > "0" ]]; then
  users=( $@ )
else
  users=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "} {$3 > 499} {print $1}'`)
fi
for index in "${!users[@]}"
do
  uids[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "}{print $3}'`
  names[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "}{print $5}'`
done

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
