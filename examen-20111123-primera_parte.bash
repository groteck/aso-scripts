#!/bin/bash

users=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "} {$3 > 499} {print $1}'`)
uids=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "} {$3 > 499} {print $3}'`)
names=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"; OFS=" "} {$3 > 499} {print $5}'`)

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
