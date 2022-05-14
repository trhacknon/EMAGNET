# Emagnet v4.0.0-Beta


| Beta Version    | News                            | Tested On                          |
| :----------------- | :-------------------------------- | :----------------------------------|
| `4.0.0-Beta`       | ...                               | Gentoo                               |


![emagnet_v4](https://user-images.githubusercontent.com/26827453/167770299-c0751cf6-1870-4090-ba15-2b17d7aea027.gif)


Added `emagnet_v4.0.0-beta.sh` as its own script for now, will be built in later but its alot of job left with alot of more sources, use this for now! 

### A small explanation of what it does.

1. Emagnet visits the site with all dumps
2. Emagnet grab urls for the leaks 
   - Im not sure if I want to download the files or doing this part as we reading the files yet o
   - Once all files is downloaded we use [ripgrep](https://github.com/BurntSushi/ripgrep) for speed up things - Its fast as ****
4. Ripgrep grabs the urls the leaks are stored on, mostly times
     - `upload.ee `
     - `anonfiles.com`
     - `yandex.ru`
5. Emagnet now downloading the dump files 
6. Emagnet now sorting and doing some magic(check inside script) for sort the correct files in correct dir, we just want the dumps
7. Emagnet now save all files in ~/emagnet-temp/dump
     - Edit this to my old emanget version paths for monitoring dirs and bruteforce via the old emagnet for now
8. Emagnet doing the bruteforce job for you! Lay back and enjoy!

If you wish, add the script to your crontab and let it run every hour / day!

I do not recommend anyone to try v4.0.0 without editing the the script. 

### How to protect yourself?

Use extra security for your accounts, passwords sucks and im trying to show you why with Emagnet!

## Changelog

[Versions changelog](CHANGELOG.md).

## Authors: 

* **wuseman <wuseman@nr1.nu\>** 

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details

### Contact

  If you have problems, questions, ideas or suggestions please contact me on *_wuseman@nr1.nu_  - For faster contact visit Libera irc network or the webchat and type '/msg wuseman hi!' in the input bar and I will reply to you ASAP.
  
  Enter Libera's network via your own client 'chat.libera.chat:+6697 or use their new web client [here](https://web.libera.chat/).

### Emagnet is a private project since 2015 and was released in June @ 2018, to be continued. 

