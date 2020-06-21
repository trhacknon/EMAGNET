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
####  it under the terms of the GNU General Public License as published by ####
####  the Free Software Foundation; either version 2 of the License, or    ####
####  (at your option) any later version.                                  ####
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
### Last Modified: 02:20:06 - 2020-05-23

API_KEY=""
APACHE="/var/www"
STORAGE="$APACHE/html/emagnet/pastebin/$(date +%Y-%m-%d)"
SCRAPE_URL="https://scrape.pastebin.com/api_scraping.php"
COUNTER="$(curl -s $SCRAPE_URL|grep -io https.*|cut -d'"' -f1|awk 'length < 30'|sed 's/.com/.com\/raw/g' |wc -l)"

if [[ "$EUID" -ne "0" ]]; then
    echo -e "$basename$0: internal error -- this scirpt must be executed by root"
    exit 1
fi

curl -s "$SCRAPE_URL"|grep -iq 'not have access'
if [[ "$?" -eq "0" ]]; then
    echo -e "You have forgot to add your IP, go to https://pastebin.com/doc_scraping_api for be allowed to scrape pastebin again..."
    exit 1
fi

if ! [[ -d "$STORAGE" ]]; then
    mkdir -p "$STORAGE"
fi

if [[ "$?" -eq "0" ]]; then
    printf "%50s" | tr ' ' '-' >> $STORAGE/pastebin-uploads.txt
    echo -e "\nPastes from: $(date +%H:%m:%S\ -\ %D)" >> $STORAGE/pastebin-uploads.txt
    printf "%50s\n" | tr ' ' '-' >> $STORAGE/pastebin-uploads.txt
    curl -s $SCRAPE_URL|grep -io https.*|cut -d'"' -f1|awk 'length < 30'|sed 's/.com/.com\/raw/g' >> $STORAGE/pastebin-uploads.txt
    echo "" >> $STORAGE/pastebin-uploads.txt
else
    sleep 0
fi
