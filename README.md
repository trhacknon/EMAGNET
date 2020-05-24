# EMAGNET v3.4.2

### Before you using emagnet, please remember that with great power comes great responsibility. 

## <p align="center">![Screenshot](https://i.ibb.co/3B5GS6X/68747470733a2f2f6e72312e6e752f656d61676e65742f70726576696577732f656d61676e65745f6f6c646d6f76692e676966.gif)

| Current Version    | News                            | Tested On                          |
| :----------------- | :-------------------------------- | :----------------------------------|
| `3.4.2`            |  Support for scraping via API has been added    | Linux/MacOS/OpenWRT/Windows/Android                               |
| `3.4.1`            |  Support for SSH Tunnel/Socks5 proxy    | Linux/MacOS/OpenWRT/Windows/Android                               |
| `3.4`              |  Full support on android devices, no root required    | Linux/MacOS/OpenWRT/Windows/Android                               |

<a href="https://github.com/wuseman/EMAGNET"><img src="https://img.shields.io/github/languages/top/wuseman/emagnet.svg?color=magenta&label=Bash%2FShell"></a><a href="https://github.com/wuseman/EMAGNET/issues?q=is%3Aissue+is%3Aclosed">
<img src="https://img.shields.io/github/issues-closed/wuseman/emagnet.svg?color=light&label=Closed%20Issues"></a>
 <a href="https://github.com/wuseman/EMAGNET/issues"><img src="https://img.shields.io/github/issues-raw/wuseman/emagnet.svg?color=orange&label=Open%20Issues"></a><img src="https://img.shields.io/github/last-commit/wuseman/emagnet.svg?color=darkmagenta&label=Latest%20Commit"><a href="https://twitter.com/wuseman1">
 <img src="https://img.shields.io/website/https/nr1.nu.svg?down_color=darkred&down_message=DOWN&label=Nr1.nu%2Femagnet&up_message=UP"><img src="https://img.shields.io/github/license/wuseman/emagnet.svg?color=blue&label=License"></a></a></a>
</a>
</p>

### News:

If you have been using emagnet for a while you have probably already noticed that pastebin removed all latest uploads from the main page and from archive so they can gain more money since it is required to be a pro member for get the newest  uploads. A PRO membership will cost you 12€/Monthly. This is probably because there is so many emagnet users out there now and I don't want you to loose any leaks so from now I got you all covered for free!! Respect the real hackers that doing this for fun and sharing things for free, nobody should earn money on their work, esepecially not forum owners - but hey... I got you covered from now - 

All latest uploads can be found on: https://nr1.nu/emagnet/pastebin/2020-MM-DD/pastebin-uploads.txt and it will change folder daily, since things is hosted in russia / moscow the timezone will be (GMT+3) so 00.00(GMt+3) a new folder gonna be created.

I dont want you to miss anything so until i will re-write the emagnet_main function you can do something like the below example:

### Please remember, this is only a temporary and ugly way for bypass the recently pastebin changes:

#### Create a new bash script and then add it to crontab to run every 301s (I scraping pastebin every 300 seconds so pastebin-uploads.txt gets updated with new urls every 300 seconds), this can be done by run:

    crontab -l | { cat; * * * * sleep 301;bash ./yourscript.sh"; } | crontab - 

####  And something like below will got you covered:

    #!/bin/bash
    # This example using parallel for download files ASAP! 
    
    EMAGNET_CONF="~/.config/emagnet/emgnnet.conf"
    . $EMAGNET_CONF
    curl -s https://nr1.nu/emagnet/pastebin/$(date +%Y-%m-%d)/pastebin-uploads.txt|grep -o "https://pastebin.com.*.*raw.*"|awk '!seen[$0]++'  > ~/.pastebin-uploads.txt
    if ! [[ -d "~/.parallel" ]]; then echo "will cite"|parallel --wil-cite &> /dev/null; fi
    parallel -a ~/.pastebin-uploads.txt -j250% -n1000 wget -nc -P $EMAGNETTEMP
    # Now you can execute emagnet as usual:
    bash ~/emagnet/emagnet.sh -e # Edit this if you got emagnet stored somewhere else
    uploaded on pastebin. It's almost impossible to find leaked passwords when they are out of list on pastebin.com. Either they have been deleted by pastebin's techs or the uploads is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect.
BBC NEWS: "Pastebin: Running the site where hackers publicise their attacks"

    Emagnet is No.1 tool for fetch these leaks from pastebin

The ultimate way to run emagnet without being blocked and get as many leaked accounts as 
### About: 

Emagnet is a very powerful tool for it's purpose wich is to capture  email addresses and passwords from leaked databases uploaded on pastebin. It's almost impossible to find leaked passwords when they are out of list on pastebin.com. Either they have been deleted by pastebin's techs or the uploads is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect. 

#### BBC NEWS: ["Pastebin: Running the site where hackers publicise their attacks"](https://www.bbc.com/news/technology-17524822) 

- Emagnet is No.1 tool for fetch these leaks from pastebin

### The ultimate way to run emagnet without being blocked and get as many leaked accounts as possible (You wont miss a single file if you run emagnet as below):

     bash emagnet -t 300
     bash emagnet -q

### A sample from 2019-11-13 when running emagnet with brute force mode on for spotify:
* The result is amazing, it have never ever been so easy to hack million of peoples accounts before!
* Run emagnet on your android device, just put your android device in your pocket and emagnet will hack the accounts for you - This preview is for spotify, but emagnet has support for more protocols and it will be more supported protocols in next upgrade.

### Sit back and relax and Emagnet will do the rest, watch the video below, this is for real!

![Screenshot](.preview/emagnet-latest.gif)

### ... So how does this work? See the video below exactly line by line how it works: 

* Left side is how you see things - Right side is what actually going on:

![Screenshot](.preview/emagnet2-debug.gif)

### Getting Started:

    git clone https://github.com/wuseman/emagnet /tmp/emagnet
    cd /tmp/emagnet
    chmod +x emagnet*
    ./emagnet --emagnet
   
    That's it, have phun!

### Notice

If you run emagnet --bruteforce ssh and do not see how many ip addresses that was found it means there was no ipv4 addresses found, this is not a bug or miss from me. If there is any ipv4 addresses found then you will see how many ipv4 addresses you found, then you gonna portscan them and last you will see how many of all the ipv4 addresses found has port 22 open and then it will begin the bruteforce and using the credenticals from emgnet.conf, default is root:root. 

### System Requirements

- Bash     - Find more info about _bash_ [here](https://www.gnu.org/software/bash/)
- Wget     - Find more info about _wget_ [here](https://www.gnu.org/software/wget/)
- Curl     - Find more info about _curl_ [here](https://github.com/curl/curl)

### Wiki Sections:

- [About](https://github.com/wuseman/EMAGNET/wiki/ABOUT) - 
_How everything started._
- [Previews](https://github.com/wuseman/EMAGNET/wiki/PREVIEWS) - 
_Previews can be found here._
- [Configurations-&-Installation](https://github.com/wuseman/EMAGNET/wiki/Configurations-&-Installation) - 
_Get started with spotify brute forcing - How emagnet will work with your openvpn files._
- [Regex - Tips For Search](https://github.com/wuseman/EMAGNET/wiki/Searching-&-Regex) - How To Find your facebook credenticals, if it has been leaked._
- [Leaked Databases - Various Public Leaks](https://github.com/wuseman/EMAGNET/wiki/Leaked-Databases )

### Scripts Folder:

Nothing in this folder is required for run emagnet. It's just a place were I store various stuff that has been built for Emagnet to facilitate the usage of Emagnet

### Looking for databases, then visit below url to find some of them:

     https://github.com/wuseman/EMAGNET/wiki/Leaked-Databases 
 
## Changelog

[Versions changelog](CHANGELOG.md).

## Authors: 

* **wuseman <wuseman@nr1.nu\>** 

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details

### Contact

  If you have problems, questions, ideas or suggestions please contact me on *_wuseman@nr1.nu_  - For faster contact visit freenode irc network or the webchat and type '/msg wuseman hi!' in the input bar and I will reply you ASAP I will see the message.
  
  Enter Freenodes network via your own client 'chat.freenode.com:+6697 or use their new web client [here](https://webchat.freenode.net/)

### Notice

Attacking different kinds of accounts via emagnet that you have not been granted or allowed to attack is strictly prohibited and it breaks the law. The punishment is hard and you can even get into prison in some countries just for trying to attack for intrusion. With this said, it's *important* that all users is aware of this and when you have cloned or downloaded it's fully up to every user to take responsibility over their own actions. wuseman cannot be held responsible for the actions of any user, all users using Emagnet on their own responsibility. 

Developer: "All my previews where a brute force attack has been done is under controlling forms with 100% fully permissions by the owners. If you have any questions about this then you are welcome to contact me or the owner."

### Haters Gonna Hate

If you are one of these who dislikes _EMAGNET_ and believe the program has been developed for a reason that would break the law then I am not interested in taking part of your opinions, keep them for _yourself_! Emagnet does **NOT** leak any data at all either to the developer(s) or anyone else. No statistics at all to track any user so if you want to contact me for ask who it might was who downloaded emagnet a specific date is completely useless since i really have no idea, and to be honest I don't care.

Feel free to read the history about emagnet [here](https://github.com/wuseman/EMAGNET/wiki/About) and how everything started about this project.

#### Development of emagnet is active and is updated frequently, please use the latest version if you report issues/bugs.

### Greetings: 

_m1st_ that deliver legit leaks for us daily.

And to all ppl that is trying to sell public leaks and steal the real hackers job, f*ck you! This is one reason why I started this project, I hope this project will get widely spreaded so you will earn 0.00$ on your re-edited malware shit!

Cheers!

### Feel free to send donations if you want to support the development of the emagnet

      BTC Address: 3HxYkrvw8dDuWEJawjtin4yuPBA9Zm27RZ

### Emagnet is a private project since 2015 and was released in June @ 2018, to be continued. 



