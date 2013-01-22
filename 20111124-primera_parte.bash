#!/usr/bin/env bash
users=()
uids=()
gids=()
names=()
path=()
console=()

#check arguments number
if [[ "$#" < "1" ]]; then
  gusers=( `grep "^lpadmin:" "/etc/group" | awk 'BEGIN {FS=":"; OFS=" "} {print $4}'` )
  IFS=$','
  set -- ${gusers[@]}
fi
users=( $@ )
unset IFS
echo ${users[@]}
for index in "${!users[@]}"
do
  #arrays whit all parameters of users
  uids[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":";}{print $3}'`
  gids[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":";}{print $4}'` 
  names[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":";}{print $5}'` 
  path[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":";}{print $6}'` 
  console[$index]=`grep ${users[$index]} "/etc/passwd" | awk 'BEGIN {FS=":";}{print $7}'` 
done

for index in ${user[@]} ; do
  #add user.basckup to gropus user and backup
  adduser ${users[$index]}.backup --gid ${gids[$index]} --disabled-password --add_extra_groups backup
  #dissable user
  passwd -l ${users[$index]}
  #copy user path to user.backup path
  cp ${path[$index]} ${path[$index]}.backu
  #change owner of files of user.backup.path
  chown -R ${users[$index]} ${path[$index]}.backup 
done

