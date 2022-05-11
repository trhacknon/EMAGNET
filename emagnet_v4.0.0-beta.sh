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

# - Required Tools -------------------------------------------------------------------
#
#      Required Tools for Emagnet
#
# -----------------------------------------------------------------------------------

emagnet_required_tools() {
    RCURL="$( curl -V |awk ' FNR == 1 {print $2}'|cut -d. -f1,2)"
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

#### Some functions require root on almost all distros, installing missing packages for example.
emagnet_mustberoot() {
    (( ${EUID} > 0 )) && printf "%s\n" "$basename$0: internal error -- root privileges is required" && exit 1
}

#### Check for a working connection, using google since it is up 24/7 
emagnet_iconnection() {
    for interface in $(ls /sys/class/net/ | grep -v lo);
    do
        if [[ $(cat /sys/class/net/$interface/carrier) = 1 ]]; then 
            OnLine=1; 
        fi
    done
    if ! [ $OnLine ]; then 
        echo "Not Online" > /dev/stderr; 
        exit; 
    fi
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

#### Print LICENSE
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

# - Terminal Line--------------------------------------------------------------------
#
#      Print line as many columns your screen/monitor/terminal is
#
# -----------------------------------------------------------------------------------
function terminal_line() {
    printf "\r%*s\r%s\n" $(tput cols) "$2" "$1"|tr ' ' '-'
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
        mkdir -p ${tPATH} ${nPATH} ${dPATH} ${mPATH}  ${bPATH}  ${aPATH} ${dPATH}  
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

# - Grab Url Sources2 -----------------------------------------------------------------
#
#      Same as about 2 on site 2
# 
#-------------------------------------------------------------------------------------
function grab_urls_source2() {
    okMSG "Fetching urls from various sources..."
    #    curl -sL ${sqURL} \
    #        |grep -Eoi 'https:\/\/sql.*\/d.*"' \
    #        |sed '1d' \
    #        |sed 's/.$//g' >> "${tPATH}/urls_sqli1.txt"
    #            okMSG "Fetching urls done..."
    curl -sL ${sqURL}  \
        |grep -Eo upload.ee................................................................... \
        |awk -F'u0022' '{print $1}' \
        |sed 's/\\//g' \
        |sed 's/^/https:\/\//g' >  "${tPATH}/urls_sqli1.txt"
    }

# - Download urls1 -----------------------------------------------------------------
#
#       As you can see I have comment out the curl line as default, this means we are able
#       to wither search url via curl or downloading the files to our temp dir. 
#      
#       Since we dont wanna get to much attention on the source site, we download files
#       and we can go through our downloaded files how many times we want. Hence the wget
# 
#-------------------------------------------------------------------------------------
function download_urls_source2() { 
    #       xargs -n 1 -P 5 curl -v -sL -u "${lOGIN}" -H "${uGENT}" \
    #             --resolve ${sHOST}:443:${lHOST} -Z -r 0-1000000 -O "${tPATH}" < "${tPATH}/urls1.txt" 
    okMSG "Downloading files that will give us all dumps..."
    xargs -n 1 -P10 wget -nc -q --progress=bar:force --show-progress -U "${uAGENT}" -P ${tPATH} < "${tPATH}/urls_sqli1.txt" &> /dev/null
    rm "${tPATH}/urls_sqli1.txt"
}

# - Grep Paste Source -----------------------------------------------------------------
#
#      Now we want to grap the urls from every paste/upload/cloud site, this can be 
#      approved ALOT but mostly uploads are hosted at: 
#      upload.ee, yandex.ru and anonfiles and my function below covers them all
# 
#--------------------------------------------------------------------------------------
function grep_paste_source() {
    okMSG "Hold on, simsalabim, doing some magic..."
    rg --hidden . $tPATH \
        |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" \
        |grep -ie "^\*.ee\|.ru\|anon\|\/files\|\/d\/" \
        |grep -v "readcrumbLi\|space\|\.gif\|t.me\|assets\|\.css\|?\|php" \
        |awk '!seen[$0]++'    \
        |awk ' length($0) > 35' > ${nPATH}/urls_sqli2.txt 
            rm ${tPATH}/*
        }

# -Download Paste Source -------------------------------------------------------------
#
#       Here we going to download everything from urls2.txt to temp path
#       - This path will be wiped after script is done
#
#--------------------------------------------------------------------------------------
function download_paste_source() {
    okMSG "Ready to download from our targets..."
    #xargs -n 1 -P 5 curl -v -sL -u "${lOGIN}" -H "${uGENT}" --resolve ${sHOST}:443:${lHOST} -Z -r 0-1000000 -O ${nPATH} < "${tPATH}/urls2.txt" 
    xargs -n 1 -P10 wget -nc -q --progress=bar:force --show-progress -U "${uAGENT}" -P ${tPATH} < "${nPATH}/urls2.txt" &> /dev/null
}

# - Fetch Last Source ----------------------------------------------------------------
#
#      Here we going to scrape upload sites, anonfiles and so on...
#      and ripgrep will give us the final URL to download.
#
#--------------------------------------------------------------------------------------
function fetch_last_source2() {
    while read urls; do 
        curl -sL -u "${lOGIN}" -H "${uGENT}" \
            --resolve ${sHOST}:443:${lHOST} m \
            "${urls}"; done < ${nPATH}/urls_sqli2.txt| grep -o "https.*\/download.*txt" >> ${nPATH}/lets-download.txt
        }

# - Fetch Last Source -----------------------------------------------------------------
#
#     Final step - Download dumps
#
#--------------------------------------------------------------------------------------
function download_last_source2() {
    okMSG "Last part, we are almost done.. Hold on.."
    #xargs -n 1 -P 5 curl -v -sL -u "${lOGIN}" -H "${uGENT}" --resolve ${sHOST}:443:${lHOST} -Z -r 0-1000000 -O ${nPATH} < "${tPATH}/urls2.txt" 
    xargs -n 1 -P10 wget -nc -q --progress=bar:force --show-progress -U "${uAGENT}" -P "${dPATH}" < "${nPATH}/lets-download.txt" &> /dev/null
    #rm -rf ${tPATH}
    okMSG "Cleaning up..."
    rp="$(cat $HOME/emagnet-temp/dumps/*.txt|wc -l)"
    rf="$(ls $HOME/emagnet-temp/dumps/|wc -l)"
    okMSG "All done, found \e[1;37m[${rp}]\e[0m passwords from \e[1;37m[${rf}\e[0m] files..."
    okMSG "Happy bruteforcing..."
    rm ${nPATH}/lets-download.txt ${nPATH}/urls_sqli2.txt
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

emagnet_wmirror() {
    uGENT="$(echo -e $uGENT|cut -d: -f2|sed 's/ //g')" 
    printf "%50s\n" |tr ' ' '-'
    printf "%s\n" '+ Mirror iNFO'
    printf "%50s\n" |tr ' ' '-'
    printf '+ Save.Path.........: %s\n' "${nPATH}/mirrors/${fuURL}-$(date +%Y-%m-%d)"
    printf '+ Website.Url.......: %s \n' "${miURL}"
    echo -e "+ IP.Adreess........: ${myIP4}" 
    echo -e "+ USer-Agent........: ${uGENT}"
    printf "%50s\n" |tr ' ' '-'
    printf "%s\n" "Press enter to continue.."
    printf "%50s\n" |tr ' ' '-'
    wget -c -q --show-progress --progress=bar:force:noscroll -U "${uGENT}" -l inf -m -e robots=off -P "${mPATH}" "${miURL}"

}

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

# - Fetch Last Source ----------------------------------------------------------------
#
#     Step by step how we run things
#
#--------------------------------------------------------------------------------------
function lets_pwn() {
    emagnet_banner
    folder_check
    #grab_urls_source
    grab_urls_source2
    download_urls_source2
    grep_paste_source
    #download_paste_source
    fetch_last_source2
    #download_last_source
    download_last_source2
    echo -e "\n=========================================================================\n"
}

OPTIND=1
while getopts abchveif opt; do
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
        i) 
            echo -e "IPv4: $myIP4"
            ;;
        e)  

            lets_pwn
            ;;
        m)  
            #emagnet_wmirror
            ;;
        *)
            show_help >&2
            exit 1
            ;;
    esac
done

if [[ -z $1 ]]; then show_help; fi 
