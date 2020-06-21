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
#### Modified: 01:37:08 - 2020-06-18
##############################################################################
CURRENT_VERSION="4.0"











##############################################################################
#### Author of emagnet will be printed if --author or -a is being used     ####
###############################################################################
emagnet_author() {
cat << "EOF"

 Copyright (C) 2018-2019, wuseman

 Emagnet was founded in 2015 and was released as open source
 on github.com/wuseman/emagnet in January 2018 and is licensed
 under GNU LESSER GENERAL PUBLIC LICENSE GPLv3

   - Author: wuseman <wuseman@nr1.nu>
   - IRC   : wuseman <irc.freenode.com>

 Please report bugs/issues on:

   - https://github.com/wuseman/EMAGNET/issues

EOF
}











emagnet_mustberoot() {
  (( ${EUID} > 0 )) && printf "%s\n" "$basename$0: internal error -- root privileges is required" && exit 1
}











emagnet_license(){
  printf "%s\n" "Printing LICENSE - Use 'q' to quit"
  sleep 2
  curl -sL "https://nr1.nu/emagnet/emagnet_license.md"|less
  printf "%s\n" "Thank you.." 
}











emagnet_help() {
cat << EOF

Usage: ./$basename$0 [--author] [--emagnet] [--option] .....

  -a, --author        Show author information
  -l, --license       Show license information
  -h, --help          Display this very helpful text
  -t, --time          Set refresh time in seconds
  -V, --version       Displays version information.
  -p, --proxy         Set ssh tunnel on or off
  -i, --ip            Print you current WAN IPv4/IPv6
  -e, --emagnet       Download latest uploaded files on pastebin
                      and store email addresses and passwords
                      in sorted day directories.
  -k, --kill          Kill emagnet ghost sessions
  -S, --search        Search for email addresses and various stuff
  -q, --screen        Run emagnet in a screen

EOF
}











emagnet_conf() {
if ! [[ -f "$HOME/.config/emagnet/emagnet.conf" ]]; then
    mkdir -p "$HOME/.config/emagnet/tmp"
    cp "./emagnet.conf" $HOME/.config/emagnet/ &> /dev/null
fi

      if [[ "$?" -gt "0" ]]; then
          echo -e "$basename$0: internal error -- Can't find emagnet.conf, please move it to $HOME/.config/emagnet/ manually"
          exit 1
      fi

    CONF="$HOME/.config/emagnet/emagnet.conf"
    source "$CONF" &> /dev/null
}











emagnet_required_tools() {
     for cmd in wget curl; do 
         which $cmd &> /dev/null
             if [[ "$?" -gt 0 ]]; then 
                 echo -e "$basename$0: internal error -- $cmd is required to be installed, exiting."
                 exit 1
             fi
     done
}











emagnet_version() {
    if [[ "$VERSION" != "$CURRENT_VERSION" ]]; then
               echo -e "$basename$0: internal error -- You are using an old emagnet.conf..."
               echo -e "$basename$0: internal error -- Download correct config file from https://github.com/wuseman/emagnet"
               echo -e "$basename$0: internal error -- When you got the correct version, move emagnet.conf into $HOME/.config/emagnet/ and please try again"
               mv $HOME/.config/emagnet/emagnet.conf $HOME/.config/emagnet/emagnet.conf.bak
               exit 1 
    fi
}











emagnet_clear() { 
    clear
}











emagnet_banner() {
cat << "EOF"
     _                      _______                      _
  _dMMMb._              .adOOOOOOOOOba.              _,dMMMb_
 dP'  ~YMMb            dOOOOOOOOOOOOOOOb            aMMP~  `Yb
 V      ~"Mb          dOOOOOOOOOOOOOOOOOb          dM"~      V
          `Mb.       dOOOOOOOOOOOOOOOOOOOb       ,dM'
           `YMb._   |OOOOOOOOOOOOOOOOOOOOO|   _,dMP'
      __     `YMMM| OP'~"YOOOOOOOOOOOP"~`YO |MMMP'     __
    ,dMMMb.     ~~' OO     `YOOOOOP'     OO `~~     ,dMMMb.
 _,dP~  `YMba_      OOb      `OOO'      dOO      _aMMP'  ~Yb._
             `YMMMM\`OOOo     OOO     oOOO'/MMMMP'
     ,aa.     `~YMMb `OOOb._,dOOOb._,dOOO'dMMP~'       ,aa.
   ,dMYYMba._         `OOOOOOOOOOOOOOOOO'          _,adMYYMb.
  ,MP'   `YMMba._      OOOOOOOOOOOOOOOOO       _,adMMP'   `YM.
  MP'        ~YMMMba._ YOOOOPVVVVVYOOOOP  _,adMMMMP~       `YM
  YMb           ~YMMMM\`OOOOI`````IOOOOO'/MMMMP~           dMP
   `Mb.           `YMMMb`OOOI,,,,,IOOOO'dMMMP'           ,dM'
     `'                  `OObNNNNNdOO'                   `'
                           `~OOOOO~'
EOF
printf "%64s \n\n" | tr ' ' '='
}











emagnet_iconnection() { 
    ping -i "1" -c 1 google.com &> /dev/null
        if [[ "$?" -gt "0" ]]; then 
            echo -e "$basename$0: internal error -- this feature require a inernet connection but you seems to be offline, exiting.."
            exit 1
        fi
}











emagnet_mustbefilled() {
  if [[ -z "$DEBUG"          ]];then sed -i "12d"  "$CONF";sed -i '12  i DEBUG=false'                                                                                                             "$CONF";fi
  if [[ -z "$PASTEBIN"       ]];then sed -i '21d'  "$CONF";sed -i '21  i PASTEBIN=https:\/\/nr1.nu\/emagnet\/pastebin/\$(date +%Y-%m-%d)\/pastebin.txt'                                                                                     "$CONF";fi
  if [[ -z "$TIME"           ]];then sed -i '30d'  "$CONF";sed -i "30  i TIME=200"                                                                                                                "$CONF";fi
  if [[ -z "$MYIP"           ]];then sed -i '40d'  "$CONF";sed -i "40  i MYIP=$(curl -s https://nr1.nu/i/)"                                                                                       "$CONF";fi
  if [[ -z "$WIP"            ]];then sed -i '50d'  "$CONF";sed -i '50  i WIP=https:\/\/nr1.nu\/i\/'                                                                                               "$CONF";fi
  if [[ -z "$WIP2"           ]];then sed -i '51d'  "$CONF";sed -i '51  i WIP2=https:\/\/ifconfig.co'                                                                                                                   "$CONF";fi
  if [[ -z "$EMAGNET"        ]];then sed -i '70d'  "$CONF";sed -i '70  i EMAGNET=$HOME/emagnet'                                                                                                   "$CONF";fi
  if [[ -z "$EMAGNETHOME"    ]];then sed -i "71d"  "$CONF";sed -i '71  i EMAGNETHOME=$EMAGNET\/incoming\/$(date +%Y-%m-%d)'                                                                       "$CONF";fi
  if [[ -z "$EMAGNETLOGS"    ]];then sed -i "72d"  "$CONF";sed -i '72  i EMAGNETLOGS=$EMAGNETHOME/logs'                                                                                           "$CONF";fi
  if [[ -z "$EMAGNETPW"      ]];then sed -i "73d"  "$CONF";sed -i '73  i EMAGNETPW=$EMAGNETHOME\/password-files'                                                                                  "$CONF";fi
  if [[ -z "$EMAGNETALL"     ]];then sed -i "74d"  "$CONF";sed -i '74  i EMAGNETALL=$EMAGNETHOME\/all-files'                                                                                      "$CONF";fi
  if [[ -z "$EMAGNETCRAP"    ]];then sed -i "75d"  "$CONF";sed -i '75  i EMAGNETCRAP=$EMAGNETHOME\/.pastebin'                                                                                     "$CONF";fi
  if [[ -z "$EMAGNETTEMP"    ]];then sed -i "76d"  "$CONF";sed -i '76  i EMAGNETTEMP=$EMAGNETHOME\/.temp'                                                                                         "$CONF";fi
  if [[ -z "$EMAGNETARCHIVE" ]];then sed -i "77d"  "$CONF";sed -i '77  i EMAGNETARCHIVE=$EMAGNET/archive'                                                                                         "$CONF";fi
  if [[ -z "$EMAGNETDB"      ]];then sed -i "78d"  "$CONF";sed -i '78  i EMAGNETDB=$EMAGNETHOME\/email-files'                                                                                     "$CONF";fi
  if [[ -z "$EMAGNETBACKUP"  ]];then sed -i "79d"  "$CONF";sed -i '79  i EMAGNETBACKUP=$EMAGNET/backup'                                                                                           "$CONF";fi
  if [[ -z "$EMAGNETSYNTAX"  ]];then sed -i "80d"  "$CONF";sed -i '80  i EMAGNETSYNTAX=$EMAGNETHOME\/sorted-by-syntax'                                                                            "$CONF";fi
  if [[ -z "$EMAGNETCRACKED" ]];then sed -i "81d"  "$CONF";sed -i '81  i EMAGNETCRACKED=$EMAGNET/cracked-accounts'                                                                                "$CONF";fi
  if [[ -z "$VERSION"        ]];then sed -i '90d'  "$CONF";sed -i '90  i VERSION=4.0'                                                                                                             "$CONF";fi
  if [[ -z "$THREADS"        ]];then sed -i '99d'  "$CONF";sed -i "99  i THREADS=$(xargs --show-limits -s 1 2>&1|grep -i "parallelism"|awk '{print $8}')"                                         "$CONF";fi
  if [[ -z "$IDLETIME"       ]];then sed -i '108d' "$CONF";sed -i "108 i IDLETIME=3600"                                                                                                           "$CONF";fi
  if [[ -z "$GBRUTEFORCE"    ]];then sed -i '124d' "$CONF";sed -i '124 i GBRUTEFORCE=false'                                                                                                       "$CONF";fi
  if [[ -z "$SBRUTEFORCE"    ]];then sed -i '125d' "$CONF";sed -i '125 i SBRUTEFORCE=false'                                                                                                       "$CONF";fi
  if [[ -z "$PBRUTEFORCE"    ]];then sed -i '126d' "$CONF";sed -i '126 i PBRUTEFORCE=false'                                                                                                       "$CONF";fi
  if [[ -z "$IBRUTEFORCE"    ]];then sed -i '127d' "$CONF";sed -i '127 i IBRUTEFORCE=false'                                                                                                       "$CONF";fi
  if [[ -z "$BBRUTEFORCE"    ]];then sed -i '128d' "$CONF";sed -i '128 i BBRUTEFORCE=template'                                                                                                    "$CONF";fi
  if [[ -z "$CBRUTEFORCE"    ]];then sed -i '129d' "$CONF";sed -i '129 i CBRUTEFORCE=template'                                                                                                    "$CONF";fi
  if [[ -z "$DBRUTEFORCE"    ]];then sed -i '130d' "$CONF";sed -i '130 i DBRUTEFORCE=template'                                                                                                    "$CONF";fi
  if [[ -z "$EBRUTEFORCE"    ]];then sed -i '131d' "$CONF";sed -i '131 i EBRUTEFORCE=template'                                                                                                    "$CONF";fi
  if [[ -z "$EMAIL2SEND"     ]];then sed -i '140d' "$CONF";sed -i '140 i EMAIL2SEND='                                                                                                             "$CONF";fi
  if [[ -z "$NOTIFY"         ]];then sed -i '149d' "$CONF";sed -i '149 i NOTIFY=false'                                                                                                            "$CONF";fi
  if [[ -z "$VPN"            ]];then sed -i '161d' "$CONF";sed -i '161 i VPN=false'                                                                                                               "$CONF";fi
  if [[ -z "$VPNROOT"        ]];then sed -i '162d' "$CONF";sed -i '162 i VPNROOT=/etc/openvpn'                                                                                                    "$CONF";fi
  if [[ -z "$VPNPROVIDER"    ]];then sed -i '163d' "$CONF";sed -i '163 i VPNPROVIDER=$VPNROOT/'                                                                                                   "$CONF";fi
  if [[ -z "$VPNCOUNTRYS"    ]];then sed -i '164d' "$CONF";sed -i '164 i VPNCOUNTRYS="belgium bulgaria czhech denmark spain finland uk uk-london uk-manchester greece hongkong hungaria italy"'   "$CONF";fi
  if [[ -z "$SSHUSER"        ]];then sed -i '176d' "$CONF";sed -i '176 i SSHUSER="root"'                                                                                                          "$CONF";fi
  if [[ -z "$SSHPORT"        ]];then sed -i '177d' "$CONF";sed -i '177 i SSHPORT="22"'                                                                                                            "$CONF";fi
  if [[ -z "$SSHPASS"        ]];then sed -i '178d' "$CONF";sed -i '178 i SSHPASS='                                                                                                                "$CONF";fi
  if [[ -z "$SSHTARGETS"     ]];then sed -i '179d' "$CONF";sed -i '179 i SSHTARGETS="$HOME/.config/emagnet/tmp/.emagnet-sshbruter.txt"'                                                           "$CONF";fi
  if [[ -z "$SSHPORTSCAN"    ]];then sed -i '180d' "$CONF";sed -i '180 i SSHPORTSCAN="$HOME/.config/emagnet/tmp/.emagnet-portscan.txt"'                                                           "$CONF";fi
  if [[ -z "$RDPUSER"        ]];then sed -i '192d' "$CONF";sed -i '192 i RDPUSER="Administrator"'                                                                                                 "$CONF";fi
  if [[ -z "$RDPPORT"        ]];then sed -i '193d' "$CONF";sed -i '193 i RDPPORT="3389"'                                                                                                          "$CONF";fi
  if [[ -z "$RDPPASS"        ]];then sed -i '194d' "$CONF";sed -i '194 i RDPPASS="qwerty"'                                                                                                        "$CONF";fi
  if [[ -z "$RDPTARGETS"     ]];then sed -i '195d' "$CONF";sed -i '195 i RDPTARGETS="$HOME/.config/emagnet/tmp/.emagnet-rdpbruter.txt"'                                                           "$CONF";fi
  if [[ -z "$RDPPORTSCAN"    ]];then sed -i '196d' "$CONF";sed -i '196 i RDPPORTSCAN="$HOME/.config/emagnet/tmp/.emagnet-portscan.txt"'                                                           "$CONF";fi
  if [[ -z "$USERAGENT"      ]];then sed -i '206d' "$CONF";sed -i '206 i USERAGENT=Mosaic/0.9'                                                                                                    "$CONF";fi
  if [[ -z "$PROXY"          ]];then sed -i '219d' "$CONF";sed -i '219 i PROXY=false'                                                                                                             "$CONF";fi                                                                                                           
  if [[ -z "$PROXYHOST"      ]];then sed -i '220d' "$CONF";sed -i '220 i PROXY=localhost'                                                                                                         "$CONF";fi
  if [[ -z "$PROXYPORT"      ]];then sed -i '221d' "$CONF";sed -i '221 i PROXY=5000'                                                                                                              "$CONF";fi
  if [[ -z "$PROXYUSER"      ]];then sed -i '222d' "$CONF";sed -i '222 i PROXY=user'                                                                                                              "$CONF";fi
  if [[ -z "$PROXYPORT"      ]];then sed -i '223d' "$CONF";sed -i '223 i PROXY=password'                                                                                                          "$CONF";fi
}











# Check so all paths has been created so we can use emagnet
emagnet_paths() {
if ! [[ -d ${EMAGNETALL} ]]; then
      PATHS="${EMAGNETHOME} ${EMAGNETCRACKED} ${EMAGNETDB} ${EMAGNETPW} ${EMAGNETTEMP} ${EMAGNETCRAP} ${EMAGNETALL} ${EMAGNETARCHIVE} ${EMAGNETLOGS}"
         for DIRS in ${PATHS}; do 
          if ! [[ -d "${DIRS}" ]]; then
             mkdir -p "${DIRS}" &> /dev/null
          fi
         done
fi
}










###############################################################################
#### If you have a ghost session of emagnet use ./emagnet -k               ####
###############################################################################
emagnet_kill() {
ESESSIONS=$(ps aux|grep -i emagnet |awk '{print $2}'|sed '$d')
NRESESSIONS=$(ps aux|grep -i "emagnet"|awk '{print $2}'|sed '$d'|wc -l)
NRINSCREEN="$(screen -ls |grep emagnet|awk -F"." '{print $1}'|sed 's/\t//g'|wc -l)"
INSCREEN="$(screen -ls |grep emagnet|awk -F"." '{print $1}'|sed 's/\t//g')"

 if [[ "$INSCREEN" -gt "0" ]]; then 
   for screens in "$INSCREEN"; do 
    screen -X -S "$screens" kill; 
    [[ "$?" = "0" ]] &&  echo -e "[\e[1;31m<<\e[0m] - $NRINSCREEN emagnet screens has been killed\n"
    done
 fi
   
   if [[ "$NRESESSIONS" -lt "3" ]]; then 
     echo -e "$basename$0: internal error -- 0 emagnet sessions is currently running";else 
     echo -e "$basename$0: killed $(echo $NRESESSIONS-2|bc) emagnet sessions"
     kill -9 $ESESSIONS &> /dev/null
   fi
}












###############################################################################
#### Sometimes pastebin is under heavy load and you wont be able to scrape ####
#### the site so then we sleep 60 seconds until we can scrape it again     ####
###############################################################################
emagnet_heavyload() {
    for (( ; ; )); do
     wait_time=60
     temp_cnt="${wait_time}"
      while [[ "${temp_cnt}" -gt 0 ]]; do
      printf "\rPastebin is currently under heavy load, will continue in: \e[1;1m%1d\e[0m" ${temp_cnt}
      printf " seconds"
      sleep 1
      ((temp_cnt--))
      done
      echo
      bash "$basename$0" --emagnet
      done
      bash "$basename$0" --emagnet
}












# This is for count down in seconds for see emagnet is actually running
emagnet_analyzer() {
   wait_time=$TIME
   temp_cnt=${wait_time}
         while [[ "${temp_cnt}" -gt "0" ]]; do
              printf "\r         I'll Will Find You <-%2d -> It's A Matter Of Time" ${temp_cnt}
              sleep 1
              ((temp_cnt--))
          done
}












# Before we do anything we print analyzing, 100 milli seconds between each print of character
emagnet_analyzing_message() {
    text="Analyzing..."
    delay="0.1"
    printf "%26s"
        for analyzing in $(seq 0 $(expr length "${text}")); do 
           echo -n "${text:$analyzing:1}"
           sleep "${delay}"
        done
}











emagnet_api() {
    if [[ $API = "true" ]]; then
      sed -i 's/API=true/API=false/g' $CONF
      echo -e "You have set API to true but your IP is not whitelisted for scraping. "
      echo -e "Whitelist your ip at: https://pastebin.com/doc_scraping_api\n"
      echo -e "API has been set to false and emagnet will not be able to scrape"
      echo -e "pastebin until you added your IP, using pastebin.com/archive until then\n "
        secs=10
        shift
        msg=$@
          while [[ $secs -gt "0" ]]; do
             printf "\r\033[KContinues in %.d seconds $msg..." $((secs--))
             sleep 1
          done
        echo
    fi
}











emagnet_count_down() {
# Add all brute force stuff here later....
     emagnet_analyzer
}











# After we downloaded and counted data we want to move all temporary files to all-files
# and also because we dont want to count data from those files twice...
emagnet_move_realtime() {
         mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
         rm "$HOME/.config/emagnet/tmp/.emagnet" "$HOME/.config/emagnet/tmp/.emagnet1"  &> /dev/null
 }












emagnet_main() {
# This is not in use, use this when using pastebin.com instead
# ------------------------------------------------------------
#  if [[ $? -gt "0" ]]; then
#    curl -s -H "$USERAGENT" https://scrape.pastebin.com/api_scraping.php > $EMAGNETTEMP/.status
#      grep -qi "blocked your IP" /$EMAGNETTEMP/.status
#        if [[ "$?" = "0" ]]; then emagnet_banned;fi    
#      grep -qi "is under heavy load right now" /$EMAGNETTEMP/.status
#        if [[" $?" = "0" ]]; then emagnet_heavyload;fi 
#      grep -qi "TO GET ACCESS" /$EMAGNETTEMP/.status
#        if [[ "$?" = "0" ]]; then emagnet_api;fi
#      rm $EMAGNETTEMP/.status &> /dev/null
#  fi

curl -Ls https://nr1.nu/emagnet/pastebin/$(date +%Y-%m-%d)/pastebin.txt > $HOME/.config/emagnet/tmp/.emagnet1
grep -q "raw" $HOME/.config/emagnet/tmp/.emagnet1
ls -1 $EMAGNETALL|sort > "$HOME/.config/emagnet/tmp/.1"
cat "$HOME/.config/emagnet/tmp/.emagnet1"|sort|cut -d/ -f5 > "$HOME/.config/emagnet/tmp/.2"
grep  -v -x -F -f "$HOME/.config/emagnet/tmp/.1" "$HOME/.config/emagnet/tmp/.2" |awk -F, '!seen[$1]++'|sed "s/^/https:\/\/pastebin.com\/raw\//g" > "$HOME/.config/emagnet/tmp/.emagnet"
rm "$HOME/.config/emagnet/tmp/.1" "$HOME/.config/emagnet/tmp/.2" &> /dev/null

# Downloading new pastes we found, no duplicates will be downloaded of course
      xargs -P "$(xargs --show-limits -s 1 2>&1|grep -i "parallelism"|awk '{print $8}')" -n 1 wget --user-agent="${USERAGENT}" -q -nc -P "$EMAGNETTEMP" < $HOME/.config/emagnet/tmp/.emagnet &> /dev/null
      tt="$(ls $EMAGNETTEMP| wc -l)"

# Count stats and print them in realtime
el=$(grep -rEiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' $EMAGNETTEMP|cut -d: -f2|tr ' ' '\n'|awk -F, '!seen[$1]++')
et=$(grep -rEiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' $EMAGNETTEMP|tr ' ' '\n'|wc -l)
ef=$(grep -rEiEio "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b" $EMAGNETTEMP|grep '\S'|sed 's/|/:/g'|awk '{print $1}'|cut -d: -f1|uniq|grep -v '"'\|','\|'<'|tr ' ' '\n')
pf=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b\\:.*$" $EMAGNETTEMP|grep '\S'|sed 's/|/:/g'|awk '{print $1}'|cut -d: -f1|uniq|grep -v '"'\|','\|'<'|tr ' ' '\n')
pl=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b\\:.*$" "$EMAGNETTEMP"|awk '{print $1}'|cut -d':' -f2,3|cut -d'|' -f1|awk -F, '!seen[$1]++'|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'\|'index.html'\|'alerts'|grep -v '/')
pt=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" $EMAGNETTEMP|awk '{print $1}'|cut -d: -f2,3|uniq|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'|grep -v /|wc -l)

# We want to clear screen after we counted stuff
    emagnet_clear
    emagnet_banner

###################################################################
# If we found both passwords and email addresses then we do below #
# --------------------------------------------------------------- #
# Notice about sleep:                                             #
# Sleep 2 below counters is added so user will be able to see     #
# what stats we have collected, otherwise it will just            #
# go on and on and we wont see any stats                          # 
###################################################################
if [[ "$pt" -gt "0" ]] && [[ "$et" -gt "0" ]]; then
            echo -e "[$(date +%d/%m/%Y\ -\ %H:%M)]: Found ${pt} passwords from: $EMAGNETPW/${pf##*/}"      | xargs >> "$EMAGNETLOGS/emagnet.log"
            echo -e "[$(date +%d/%m/%Y\ -\ %H:%M)]: Found ${et} email addresses from: $EMAGNETDB/${ef##*/}"|xargs >> "$EMAGNETLOGS/emagnet.log"
            echo -e "${pl}" >> $EMAGNETLOGS/passwords-from-pastebin.txt
            echo -e "${el}" >> $EMAGNETLOGS/emails-from-pastebin.txt
            cp -rn ${ef} $EMAGNETDB/ &> /dev/null
            cp -rn ${pf} $EMAGNETPW/ &> /dev/null
            if [[ ${tt} -lt "10" ]]; then tt=0${tt};fi
            if [[ ${et} -lt "10" ]]; then et=0${et};fi
            if [[ ${pt} -lt "10" ]]; then pt=0${pt};fi
            echo -e "                       - Files Downloaded\r             [\e[1;32m$tt\e[0m]"
            echo -e "                       - Passwords Found \r             [\e[1;32m$pt\e[0m]"
            echo -e "                       - Email Addresses Found \r             [\e[1;32m$et\e[0m]\n"
            emagnet_move_realtime
            sleep 2                         

###################################################################
# If we found no passwords and mail addresses only we do below    #
###################################################################
elif [[ "$pt" = "0" ]] && [[ "$et" -gt "0" ]]; then
            echo -e "[$(date +%d/%m/%Y\ -\ %H:%M)]: Found ${et} email addresses from: $EMAGNETDB/${ef##*/}"|xargs >> "$EMAGNETLOGS/emagnet.log"
            echo -e "${el}" >> $EMAGNETLOGS/emails-from-pastebin.txt
            cp -rn ${ef} $EMAGNETDB/ &> /dev/null
            if [[ ${tt} -lt "10" ]]; then tt=0${tt};fi
            if [[ ${et} -lt "10" ]]; then et=0${et};fi
            echo -e "                       - Files Downloaded\r             [\e[1;32m$tt\e[0m] "
            echo -e "                       - Passwords Found \r             [\e[1;31m00\e[0m] "
            echo -e "                       - Email Addresses Found \r             [\e[1;32m$et\e[0m] \n"
            emagnet_move_realtime
            sleep 2                         
            
###################################################################
# If we found no passwords and no mail addresses we print 00      #
###################################################################
elif [[ "$pt" = "0" ]] && [[ "$et" = "0" ]] && [[ ${tt} = "0" ]]; then
            echo -e "[\e[1;31m<<\e[0m] - No new files could be downloaded...\n[\e[1;31m<<\e[0m] - You may want to raise time in emagnet.conf.."
            sleep 2                         
        else
            if [[ ${tt} -lt "10" ]]; then tt=0${tt};fi
            echo -e "                       - Files Downloaded\r             [\e[1;32m$tt\e[0m] "
            echo -e "                       - Passwords found \r             [\e[1;31m00\e[0m] "
            echo -e "                       - Email Addresses Found \r             [\e[1;31m00\e[0m] \n"        
            emagnet_move_realtime
            sleep 2
fi
}











emagnet_screen() {
 mkdir -p /tmp/screen/S-root &> /dev/null
 chmod 755 /tmp/screen &> /dev/null
 chmod -R 700 /tmp/screen/S-root &> /dev/null
 hash screen &> /dev/null
     if [[ "$?" -gt "0" ]]; then 
       echo -e "$basename$0: internal error -- Screen is required to be installed before you can emagnet in background..."
       exit 1
     fi
         pid="$(ps aux |grep emagnet)"
         printf "$basename$0: emagnet has been started in background (pid:$(ps aux|grep "SCREEN -dmS emagnet"|awk '{print $2}'|head -n1))\n"
         screen -S "emagnet" -dm bash "$basename$0" --emagnet
}












emagnet_first_run() {
CONF="$HOME/.config/emagnet/emagnet.conf"
if ! [[ -f "$CONF" ]]; then
        emagnet_conf
        emagnet_required_tools
        emagnet_paths
        emagnet_mustbefilled
        emagnet_version
fi
}











emagnet_lets_run() {
    for (( ; ; )); do  
        emagnet_conf                         # Source emagnet-conf so we know all settings for emagnet
        emagnet_first_run
        emagnet_paths
        emagnet_iconnection                  # Check if we got internet, otherwise we stop
        emagnet_api                          # Count down in milliseconds until we will download and scrape pastebin again
        emagnet_version                      # Check so we using the correct emagnet.conf
        emagnet_clear
        emagnet_banner
        emagnet_analyzer                     # Change this with emagnet_count_down when we have added brute force stuff again
        emagnet_clear                        # Clear screen
        emagnet_banner                       # Printbanner
        emagnet_analyzing_message            # Print Analyzing before we count data, it takes 0.9seconds and looks better  
        emagnet_main                         # Scrape pastebin, download files and then count stats
done
}






















if [[  "${1}" = "--emagnet" || "${1}" = "-e" || "${1}" = "--e" || "${1}" = "-emagnet" ]]; then
    emagnet_first_run
    emagnet_lets_run


elif [[ ${1} = "--author" || ${1} = "-a" || ${1} = "--a" || ${1} = "-author" ]]; then
    emagnet_author


elif [[ ${1} = "--license"  || ${1} = "--l" || ${1} = "-l" || ${1} = "-license" ]]; then
    emagnet_license


elif [[ ${1} = "--screen" ]]; then
    emagnet_screen


elif [[ ${1} = "--kill" || ${1} = "--k" || ${1} = "-kill" || ${1} = "-k" ]]; then
    emagnet_kill


elif [[ ${1} = "--time" || ${1} = "--t" || ${1} = "-time" || ${1} = "-t" ]]; then
  emagnet_conf
     if [[ -z "$2" ]]; then echo "emagnet: internal error -- time require a number to be used";exit 1;fi
     
     re='^[0-9]+$'
        if ! [[ $2 =~ $re ]]; then  
          echo -e "emagnet: internal error -- that's not a valid number" >&2
          exit 1
        fi
     
     sed -i '30d' "$CONF"
     sed -i "30 i TIME=$2" "$CONF"
     printf "%s\n" "$basename$0: config file has been updated -- time has been set to: $2 seconds"
     exit 0

elif [[ ${1} = "--version" || ${1} = "--v"  || ${1} = "-v" || ${1} = "-version" ]]; then
     VERSION="$(cat ${PWD}/$basname$0|grep -oi "CURRENT_VERSION.*"|head -n1 |grep -oE "[0-9].*"|cut -d'"' -f1)"
     printf "%s\n" "Emagnet Version: $VERSION"
     

elif [[ ${1} = "--help" || ${1} = "--h" || ${1} = "-help" || ${1} = "-h" ]]; then
     emagnet_help


# If $1 is empty, print help
elif [[ -z ${1} ]]; then
     emagnet_help


else
    emagnet_help
fi  
