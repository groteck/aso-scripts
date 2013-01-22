#!/bin/bash
users=()
userspath=()
unit=1

if [[ "$#" > "0" ]]; then
  parameters=( $@ )
  for index in ${!parameters[@]} ; do
    if [[ "${parameters[$index]}" == "-m" ]]; then
      unit=1048576
    elif [[ "${parameters[$index]}" == "-k" ]]; then
      if [$unit eq 1]; then
        unit=1024
      else
        echo "Error: you can use -k or -m, but you can't use both"
        exit 1
      fi
    elif [[ "${parameters[$index]}" =~ ^[0-9]+$ ]]; then
      users[$index]=`grep ":${parameters[$index]}:" /etc/passwd | awk 'BEGIN {FS=":"} {$1}'`
      userspath[$index]=`grep ":${parameters[$index]}:" /etc/passwd | awk 'BEGIN {FS=":"} {$6}'`
    else
      users[$index]=`grep "^${parameters[$index]}:" /etc/passwd | awk 'BEGIN {FS=":"} {$1}'`
      userspath[$index]=`grep "^${parameters[$index]}:" /etc/passwd | awk 'BEGIN {FS=":"} {$6}'`
    fi
  done
else
  echo "Select some user please"
  exit 1
fi


