#!/bin/bash
###############################################################################
###############################################################################
###                                                                         ###
### Author: wuseman <wuseman@nr1.nu>                                        ###
### IRC: Freenode @ wuseman                                                 ###
###                                                                         ###
###############################################################################
############################## AUTHOR WUSMAN ##################################
###############################################################################
###                                                                         ###
### If you will copy any developers work and claim you are the dev/founder  ###
### it wont make you a hacker - The only person you're fooling is yourself  ###
### so please respect all developers and GPL Licenses no matter if it's my  ###
### script, tool or project or if it's anyone else, thank you!              ###
###                                                                         ###
###############################################################################
###########################o###################################################
###############################################################################
####                                                                       ####
####  Copyright (C) 2018-2020, wuseman                                     ####
####                                                                       ####
####  This program is free software; you can redistribute it and/or modify ####
####  it under the terms of the GNU General Pu<blic License as published by ###
####  the Free Software Foundation; either version 2 of the License, or    ####
####  (at your option) any later wversion.                                 ####
####                                                                       ####
####  This program is distributed in the hope that it will be useful,      ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        ####
####  GNU General Public License for more details.                         ####
####                                                                       ####
####  You must obey the GNU General Public License. If you will modify     ####
####  the file(s), you may extend this exception to your version           ####
####  of the file(s), but you are not obligated to do so.  If you do not   ####
####  wish to do so, delete this exception statement from your version.    ####
####  If you delete this exception statement from all source files in the  ####
####  program, then also delete it here.                                   ####
####                                                                       ####
###############################################################################
###############################################################################
### Last Modified: 10:28:37 - 2020-08-14

# Some default stuff:
SKIPLIST="archive\doc_api\|doc_api\|archive\|contact\|html"

# First we must know were to download
source "$HOME/.config/emagnet/emagnet.conf" &> /dev/null

# IF we didn't create dirs yet, we now will.
mkdir -p $EMAGNETHOME
mkdir -p $EMAGNETTEMP

#### Show on screen we started
   echo -e "Please wait, scraping all leakers profiles @\e[1;37mpastebin.com\e[0m"

#### Now we gonna grab all leakers we have found since earlier for download all their downloads
   ls -1 $EMAGNET/password-files|sed 's/^/https:\/\/pastebin.com\//g'|xargs -P100 -n1 curl -sL >> $EMAGNETTEMP/.temp.txt

# If .temp.txt exist we gonna remove the file first
# Grab all usernames so we know from wich user we want to download

   [[ -f $EMAGNETTEMP/.temp.txt ]] && rm $EMAGNETTEMP/.temp.txt
   egrep -io '\/u.*.">.*' $EMAGNETTEMP/.temp.txt|grep -o -P '(?<=\/u\/).*(?=")'|grep -o "^[A-Za-z0-9]*"|awk '!seen[$0]++' >> $EMAGNETTEMP/.temp-user.txt

# Count total leakers
   LEAKERS=$(egrep -io '\/u.*.">.*' $EMAGNETTEMP/.temp.txt|grep -o -P '(?<=\/u\/).*(?=")'|grep -o "^[A-Za-z0-9]*"|awk '!seen[$0]++'|wc -l)

# Now create a pastebin url from every user we found
   sed -i 's/^/https:\/\/pastebin.com\/u\//g' $EMAGNETTEMP/.temp-user.txt

# Now create a url for user files:
   while read users_profile; do
      curl -Ls $users_profile|awk -F'href="/' '{print $2}'|cut -d'"' -f1|awk 'length($0)>6 && length($0)<9'|sed 's/^/https:\/\/pastebin.com\/raw\//g'|grep -v $SKIPLIST >> $EMAGNETTEMP/.download-by-user.txt
   done < $EMAGNETTEMP/.temp-user.txt

# Now let us download every file
      echo -e "We going to download all files frmo $LEAKERS leakers....\n\e[1;31mDon't stop!!\e[0m You will get banned anyway if there is alot of pastes, the ban is _not_ instant from pastebin..."
         while read line; do
              source "$HOME/.config/emagnet/emagnet.conf" &> /dev/null
              echo -e "\e[1;32m+]\ẹ[0m Downloading all uploads from: $line"
              xargs -P 1201 -n 1 wget --no-check-certificate --user-agent=${USERAGENT} -nc -q -P $EMAGNETTEMP < $EMAGNETTEMP/.download-by-user.txt
         done < $EMAGNETTEMP/.download-by-user.txt
      
# We are done! :) 
      echo "Done..."

