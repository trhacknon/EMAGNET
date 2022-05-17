#!/bin/bash

# - iNFO -----------------------------------------------------------------------------
#
#        Author: wuseman <wuseman@nr1.nu>
#      FileName: emagnet.sh
#       Version: 4.0.0
#
#       Created: 2022-04-08 (06:30:15)
#      Modified: 2022-05-10 (23:46:41)
#
#           iRC: wuseman (Libera/EFnet/LinkNet) 
#       Website: https://www.nr1.nu/
#        GitHub: https://github.com/wuseman/
#
# - Descrpiption --------------------------------------------------------------------
#
#      No description has been added
#
# - LiCENSE -------------------------------------------------------------------------
#
#      Copyright (C) 2022, wuseman                                     
#                                                                       
#      This program is free software; you can redistribute it and/or modify 
#      it under the terms of the GNU General Public License as published by 
#      the Free Software Foundation; either version 3 of the License, or    
#      (at your option) any later version.                                  
#                                                                       
#      This program is distributed in the hope that it will be useful,      
#      but WITHOUT ANY WARRANTY; without even the implied warranty of       
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        
#      GNU General Public License for more details.                         
#                                                                       
#      You must obey the GNU General Public License. If you will modify     
#      the file(s), you may extend this exception to your version           
#      of the file(s), but you are not obligated to do so.  If you do not   
#      wish to do so, delete this exception statement from your version.    
#      If you delete this exception statement from all source files in the  
#      program, then also delete it here.                                   
#
#      You should have received a copy of the GNU General Public License
#      along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# - End of Header ------------------------------------------------------------------

# - Settings -----------------------------------------------------------------------
#
#      lOGIN:  Username and Password we gonna send to server, change this
#              to whatever you want - Dont use your real username:pass ofc
#              this is just for make the server owner confused
#     aPATH:   archive path (not being used atm)
#     dPATH:   folder we store all dumps in
#     mPATH:   folder we store website mirror in
#     tPATH:   Temp path we downloading and reading files from, we wipe it after     
#              every time emagnet has been executed
#     uGENT:   User-Agent - Once again, for not leave any traces we dont need
#     lHOST:   resolve-host, require curl 7.49.0 minium (man curl)
#     fuURL:   Our Source
#     npURL:   url and pages we using to grab latest leaks
#     vERSION: Version of this script
#
# -----------------------------------------------------------------------------------
lOGIN="cryingkidzFBIisH3re:cryingidzFBIisH3re"
aPATH="$HOME/emagnet-temp/archive"
aPATH="$HOME/emagnet-temp/backup"
dPATH="$HOME/emagnet-temp/dumps"
lPATH="$HOME/emagnet-temp/logs"
nPATH="$HOME/emagnet-temp"
mPATH="$HOME/emagnet-temp/mirrors"
tPATH="$HOME/emagnet-temp/.temp"
uGENT="User-Agent: somehost.gov"
sHOST="somehost.gov"
lHOST="127.0.0.1"
fuURL=""
sqURL="https://sqli.cloud/"
xxURL=""
xxURL=""
npURL="https://${fuURL}/threads/latest?page={1,3}"
miURL="https://${fuURL}/"
myIP4="$(curl -sL ifconfig.co)" 
vERSION="4.0.0"



# - Emagnet Banner ------------------------------------------------------------------
#
#      Ascii to print when script is running
#
#------------------------------------------------------------------------------------
function emagnet_banner() {
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

= Emagnet v4.0.0 ===================================== © wuseman ========

EOF

#printf "\n%64s \n\n" | tr ' ' '='
}


# - Terminal Line--------------------------------------------------------------------
#
#      Print line as many columns your screen/monitor/terminal is
#
# -----------------------------------------------------------------------------------
function terminal_line() {
    printf "\r%*s\r%s\n" $(tput cols) "$2" "$1"|tr ' ' '-'
}

# - License -------------------------------------------------------------------------
#
#      Print License
#
# -----------------------------------------------------------------------------------
emagnet_license(){
    printf "%s\n" "Printing LICENSE - Use 'q' to quit"
    sleep 2
    curl -sL "https://w.nr1.nu/archive/emagnet/LICENSE.md"|less
    printf "%s\n" "Thank you.." 
}

# -Author ---------------------------------------------------------------------------
#
#      Print author of Emagnet project
#
# -----------------------------------------------------------------------------------
emagnet_author() {
    cat << "EOF"

 Copyright (C) 2018-2022, wuseman

 Emagnet was founded in 2015 and was released as open source
 on github.com/wuseman/emagnet in January 2018 and is licensed
 under GNU LESSER GENERAL PUBLIC LICENSE GPLv3

   - Author: wuseman <wuseman@nr1.nu>
   - IRC   : wuseman <irc.freenode.com>

 Please report bugs/issues on:

   - https://github.com/wuseman/emagnet

EOF
}


# - Show Help --------------------------------------------------------------------
#
#      Print Help for User
#
# -----------------------------------------------------------------------------------
function show_help() {
    cat << EOF

Usage: ${0##*/} [-b] [-e] [-m] [-h] ...

      -a          print author info
      -b          print emagnet banner
      -c          check if extra security is used or not that will block us
      -e          fetch latest urls and quit
      -i          print your ip addresses

EOF
}


# - Ok Message _--------------------------------------------------------------------
#
#      This is for make everything alot more beauty, just 'okMsg "msgtoprint"''
#
#-----------------------------------------------------------------------------------
okMSG() { 
    echo -e "[\e[1;32m+\e[0m] - $*"
}

# - Unknown Message ----------------------------------------------------------------
#
#      Something between ok and error message (yellow color) =)
#
#-----------------------------------------------------------------------------------
unMSG() { 
    echo -e "[\e[1;33m+\e[0m] - $*"
}

# - Error Message --------------------------------------------------------------------
#
#      This is for make everything alot more beauty, just 'errMsg "msgtoprint"''
#
#------------------------------------------------------------------------------------
errMSG() {
    echo -e "[\e[1;31m-\e[0m] - $*" >&2
}

# - Error Message --------------------------------------------------------------------
#
#      Required folders must exist so we we gonna create them if they not exist
#
#-------------------------------------------------------------------------------------
function folder_check() {
    if [[ ! -d ${nPATH} ]]; then 
        okMSG "This is first time Emagnet v${vERSION} is launched, creating required dirs..."
        mkdir -p ${tPATH} ${nPATH} ${dPATH} ${mPATH}  ${bPATH}  ${aPATH} ${dPATH}  ${lPATH}  
    fi
}

# - Internet Is Required For Some Features -------------------------------------------
#
#      We probably need to exit if the user is not root if we miss any required tool
#
# ------------------------------------------------------------------------------------
emagnet_iconnection() {
    ping -i "1" -c 1 google.com &> /dev/null
        if [[ "$?" -gt "0" ]]; then 
            echo -e "$basename$0: internal error -- this feature require a internet connection but you seems to be offline, exiting.."
            exit 1
        fi
}




# - Required Tools -------------------------------------------------------------------
#
#      Required Tools for Emagnet
#
# ------------------------------------------------------------------------------------
emagnet_required_tools() {
    RCURL="$(curl -V |awk ' FNR == 1 {print $2}'|cut -d. -f1,2)"
    if [[ $RCURL -lt "7.49" ]]; then 
        errMSG "Some commands in this script require curl v7.49 or higher installed, your current installed version is ${RCURL}";
        exit 
    fi
    for tools in wget curl awk sed rg; do 
        hash ${tools} &> /dev/null; 
        if [[ $? -ne "0" ]]; then
            echo -e "$basename$0: internal error -- wget is required to be installed, exiting."
            exit
        fi
    done
}

# - Required Tools --------------------------------------------------------------------
#
#      We probably need to exit if the user is not root if we miss any required tool
#
# -------------------------------------------------------------------------------------
emagnet_mustberoot() { 
    (( ${EUID} > 0 )) && printf "%s\n" "$basename$0: internal error -- root privileges is required" && exit ;
}



# - Kill Ghost Sessions --------------------------------------------------------------
#
#      If you have a ghost session of emagnet use ./emagnet -k
#
# ------------------------------------------------------------------------------------
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

# - Check For Blocks/Bans ------------------------------------------------------------
#
#      Check for blocks
#
# -----------------------------------------------------------------------------------
check_block() {
    unMSG "please wait..."
    curl -sL -u "${lOGIN}" -H "${uGENT}" \
        --resolve ${sHOST}:443:${lHOST} m \
        "${npURL}" |grep -iq "ddos-"
            if [[ $? = "0" ]]; then
                errMSG "internal error -- ddos-script is blocking us, change ip or try again later..."
                exit 0
            else 
                okMSG "oh boy! all fine, try ./emagnet -e, have fun...."
            fi
        }



# - Grab Url Sources -----------------------------------------------------------------
#
#      First of all, we must find all urls to go through when we search for new leaks
#      in this case we using nohide.space website, save urls into a file named urls1.txt
# 
#-------------------------------------------------------------------------------------
function grab_urls_source() {
    okMSG "Fetching latest urls from main target.."
    curl -sL -u "${lOGIN}" -H "${uGENT}" \
        --resolve ${sHOST}:443:${lHOST} m \
        "${npURL}" \
        |grep -Eo "data-preview-url.*" \
        |cut -d'"' -f2 \
        |sed "s/^/https:\/\/${fuURL}/g" \
        |sed 's/\/preview//g' > "${tPATH}/urls1.txt"
            grep -q . "${tPATH}/urls1.txt"
            if [[ $? -ne "0" ]]; then
                curl -sL -u "${lOGIN}" -H "${uGENT}" \
                    --resolve ${sHOST}:443:${lHOST} m \
                    "${npURL}"|grep -iq "java"
                                    errMSG "internal error -- ddos-script is blocking us, change ip or try again later..."
                                    exit 0
            fi
        }

# - See if the user edit's the part I tell them to do in readme ----------------------------------
#
#     Simple exit control to stop users who should not use this script.
#     this part is not included if you have downloaded the script via releases as 
#     there is a readme to read on that page: https://github.com/wuseman/EMAGNET/releases
#
#     Delete line 399->413 from this file or do it via sed:
#
#     sed -e '399,418d' emagnet_v4.0.0-beta.sh
#
#     Thx!
#
#-----------------------------------------------------------------------------------------------
echo -e "cryingkidzFBIisH3re:cryingkidzFBIisH3re"|grep -ow ${lOGIN} &> /dev/null
if [[ $? = "0" ]]; then
        errMSG "I told you to edit this script before executing it, for your own safety your lazy cow... (ow yeh, larry the cow slogan)"
        errMSG "Edit user:password for something else or remove this if statement from the script..."
        exit
fi

# - Emagnet Screen ----------------------------------------------------------------
#
#     Run things in screen
#
#--------------------------------------------------------------------------------------
emagnet_screen() {
 hash screen &> /dev/null
     if [[ "$?" -gt "0" ]]; then 
       echo -e "$basename$0: internal error -- Screen is required to be installed before you can emagnet in background..."
       exit 1
     else
       emkdir -p /tmp/screen/S-root &> /dev/null
       echmod 755 /tmp/screen &> /dev/null
       echmod -R 700 /tmp/screen/S-root &> /dev/null
      fi
         
    pid="$(ps aux |grep emagnet)"
    printf "$basename$0: emagnet has been started in background (pid:$(ps aux|grep "SCREEN -dmS emagnet"|awk '{print $2}'|head -n1))\n"
    screen -dmS "emagnet" emagnet -e
}


emagnet_main() {
   seq 1| xargs  -I % -n1 -P20|curl -sL ${sqURL}|sed 's/\\//g'|grep -Eo "(http|https)://www.[a-zA-Z0-9./?=_-]*"|sed 's/u0022//g'  > 1
   xargs -n 1 -P 18 curl -sL -u "${lOGIN}" -H "${uGENT}" --resolve ${sHOST}:443:${lHOST} < 1 |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*download.*txt" > 2
   xargs -I % -P 200 curl -m 5 -k -o /dev/null --silent --head --write-out '%{http_code}\n' %
}


# - Fetch Last Source ----------------------------------------------------------------
#
#     Step by step how we run things
#
#--------------------------------------------------------------------------------------
function lets_pwn() {
    emagnet_banner
    folder_check
    #grab_urls_source
    emagnet_main

    echo -e "\n=========================================================================\n"
}

OPTIND=1
while getopts abchveifqk opt; do
    case $opt in
        a)  emagnet_author ;;
        b)  
            emagnet_banner
            exit 0
            ;;

        c) 
            check_block
            ;;
        h)
            show_help
            exit 0
            ;;
      "k"|"-kill")
                emagnet_kill
                ;;

        i) 
            echo -e "IPv4: $myIP4"
            ;;
        e)  

            lets_pwn
            ;;
        m)  
            #emagnet_wmirror
            ;;
      "q"|"-quiet")
                emagnet_screen
                ;;
        *)
            show_help >&2
            exit 1
            ;;
    esac
done

if [[ -z $1 ]]; then show_help; fi 
