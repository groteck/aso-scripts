#!/usr/bin/env bash
pusers=()
susers=()
file=()

pusers=(`cat /etc/passwd | awk 'BEGIN {FS=":"} {print $1}'`)
susers=(`sudo cat /etc/shadow | awk 'BEGIN {FS=":"} {print $1}'`)
for puser in ${pusers[@]} ; do
  found="no"
  for suser in ${susers[@]} ; do
    if [[ $puser == $suser ]]; then
      found="si"
    fi
    for puser2 in ${pusers[@]} ; do
      if [[ $puser2 != $suser ]]; then
        echo "$puser2 aparece:no solo-en:shadow"
      fi
    done
  done
  if [[ $found != "si" ]]; then
    echo "$puser aparece:$found solo-en:passwd"
  else
    echo "$puser aparece:$found"
  fi
done
