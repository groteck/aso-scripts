#!/bin/bash

users=( `cat "/etc/passwd" | awk 'BEGIN {FS=":"} {$3 > 499} {print $1}'`)

for user in "${users[@]}"
do
  full= $user
  groups=( `grep Suser "/etc/group" | awk 'BEGIN {FS=":"} {print $1}'`)
  for group in "${groups[@]}"
  do
    full="$full $group"
  done
  print "$full"
done
