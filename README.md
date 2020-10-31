# EMAGNET v3.4.3

### Before you using emagnet, please remember that with great power comes great responsibility. 

# <p align="center">![Screenshot](https://repository-images.githubusercontent.com/165741206/f9087e00-397d-11ea-9cab-1aea419f9448)

| Current Version    | News                            | Tested On                          |
| :----------------- | :-------------------------------- | :----------------------------------|
| `3.4.3`            |  More than twice as fast as previous version    | Linux/MacOS/OpenWRT/Windows/Android                               |
| `3.4.2`            |  Support for scraping via API has been added    | Linux/MacOS/OpenWRT/Windows/Android                               |
| `3.4.1`            |  Support for SSH Tunnel/Socks5 proxy    | Linux/MacOS/OpenWRT/Windows/Android                               |
| `3.4`              |  Full support on android devices, no root required    | Linux/MacOS/OpenWRT/Windows/Android                               |

<a href="https://github.com/wuseman/EMAGNET"><img src="https://img.shields.io/github/languages/top/wuseman/emagnet.svg?color=magenta&label=Bash%2FShell"></a><a href="https://github.com/wuseman/EMAGNET/issues?q=is%3Aissue+is%3Aclosed">
<img src="https://img.shields.io/github/issues-closed/wuseman/emagnet.svg?color=light&label=Closed%20Issues"></a>
 <a href="https://github.com/wuseman/EMAGNET/issues"><img src="https://img.shields.io/github/issues-raw/wuseman/emagnet.svg?color=orange&label=Open%20Issues"></a><img src="https://img.shields.io/github/last-commit/wuseman/emagnet.svg?color=darkmagenta&label=Latest%20Commit"><a href="https://twitter.com/wuseman1">
 <img src="https://img.shields.io/website/https/nr1.nu.svg?down_color=darkred&down_message=DOWN&label=Nr1.nu%2Femagnet&up_message=UP"><img src="https://img.shields.io/github/license/wuseman/emagnet.svg?color=blue&label=License"></a></a></a>
</a>
</p>

### Notice: 

Pastebin found the vulnerability I used to get recent uploads from https://pastebin.com/archive and fixed this issue.

At the moment it is not possible to get the recent uploaded files anymore as before, you are now limited to all syntaxes exempt the default one (95% get's uploaded as 'text' and this is removed from all recent upload lists). 

Currently working on a new way to share all recent uploads for free.

Pastebin on twitter: 
https://twitter.com/pastebin/status/1250472977491091457

Read their terms of service here before this decision:

https://web.archive.org/web/20200410004902/https://pastebin.com/doc_terms_of_service

    4. Services Usage Limits
    You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service without Pastebin's express written permission. 

    Scraping refers to extracting data from our Website via an automated process, such as a bot or webcrawler. It does not refer to the collection of information through Pastebin's API. You may scrape the website for the following reasons:

     Researchers may scrape public, non-personal information from Pastebin for research purposes, only if any publications resulting from that research are open access.
    Archivists may scrape Pastebin for public data for archival purposes.
    You may not scrape Pastebin for spamming purposes, including for the purposes of selling Pastebin users' personal information, such as to recruiters, headhunters, and job boards.

    All use of Pastebin data gathered through scraping must comply with the Pastebin Privacy Statement. 
 
Emagnet users are archivists! __Right__?

We didnt get the recent uploads from __scrape.pastebin.com__, we used _pastebin.com/archive_, this means we never was under the privacy statements.

Whatever, this means that the emagnet project has ended up in a pause phase as we will not go much further until this changes, but just wait. Soon the greed will come and they will open the pro section again. They can not run this service for free, too long.

#### BBC NEWS: ["Pastebin: Running the site where hackers publicise their attacks"](https://www.bbc.com/news/technology-17524822) 

- Emagnet is No.1 tool for fetch these leaks from pastebin

### About - Emagnet v3.4.3 (2020-07-19)

Emagnet is a very powerful tool for it's purpose wich is to capture  email addresses and passwords from leaked databases uploaded on pastebin. It's almost impossible to find leaked passwords when they are out of list on pastebin.com. Either they have been deleted by pastebin's techs or the uploads is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin w

* Parallel downloading! More than twice as fast as previous version.
* 555 files downloaded, over ~20.000 accounts found to auto brute-force by one command that toke ~4.51 seconds (see proof below)
* Incredibly good results for successful attacks.
* There is __no__ other tool nearby that has more successful attempts than Emagnet.
* Emagnet is quick, easy, unique and awesome!
* Google used Emagnet source for analyze their own site for ~1year ago, this is how people trying to attack accounts today.
* No skills needed, even your grandmother can use emagnet.
* Bruteforce ssh targets, Microsoft Remote Desktop - We portscanning extremely fast for choose our targets with X port open (netcat/xargs)
* Super easy to add your own tools using inotifywait with emagnet - See script example [here](https://pastebin.com/raw/rem8bNRw)
- ./emagnet -g gmail will automate the attack for gmail/google accounts only - We skip the rest!
  - Read more on googles security blog and automated-tools(emagnet) 
  - Emagnet is 1 year after the analyze from google still the best tool for it's purpose (2020-07-19) (7% using 2FA)
  - If the user does not have 2FA enable, you will succeed!
  - URL To google security blog (This was for try 2FA security): [Google.com - Security Blog](https://security.googleblog.com/2019/05/new-research-how-effective-is-basic.html)
  - __Remember,bruteforce accounts without the owner's approval violates the law.__

### Emagnet - v3.4.3 (ssh)
![Screenshot](https://nr1.nu/emagnet/emagnet-v3.4.3-ssh.gif)

### Emagnet - v3.4.3 (spotify)
![Screenshot](https://nr1.nu/emagnet/emagnet-v3.4.3-spotify.gif)

### Emagnet - v3.4.3 (gmail)
![Screenshot](https://nr1.nu/emagnet/emagnet-v3.4.3-gmail.gif)

### Getting Started

    git clone https://github.com/wuseman/emagnet
    chmod +x emagnet/emagnet.sh
    bash emagnet/emagnet.sh --emagnet
       
### System Requirements

- Bash     - Find more info about _bash_ [here](https://www.gnu.org/software/bash/)
- Gsed     - Find more info about _gsed_ [here](https://www.gnu.org/software/sed/)
- Gawk     - Find more info about _gawk_ [here](https://www.gnu.org/software/gawk/)
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
- [Leaked Databases](https://github.com/wuseman/EMAGNET/wiki/Leaked-Databases) - Various Public Leaks

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

    Please contact me before you send a donation: wuseman@nr1.nu

### Emagnet is a private project since 2015 and was released in June @ 2018, to be continued. 

