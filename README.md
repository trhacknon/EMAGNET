# Emagnet v4.0.0-Beta

| Beta Version    | News                            | Tested On                          |
| :----------------- | :-------------------------------- | :----------------------------------|
| `4.0.0-Beta`       | Downloadingd dumps from https://sqli.cloud                    | GNU/Linux Gentoo                               |


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

## Update: 2022-05-11

https://user-images.githubusercontent.com/26827453/167771364-d3bf9c15-6753-4f44-b450-b4cfd953298f.mp4

1. Choose a Telegram Group and add a simple 's' between .me/ and /groupname
2. like: https://t.me/s/groupname - Alot of admins forgets to securing their group and have no clue about this (obviously), lets continue and dont talk this with anyone, the more ppl that will know this  the worse it gets for you and me. If you're an admin, you sucks! DOn put your users in danger because you are an idiot and do not know how to secure a simple group on telegram, lol.
3. Don't worry! This is just a bonus (bonus = wont last forever, if any group admin will see this who did not know better, then use emagnet-v4.0.0-beta instead) - This part is just added for fun and not a real part of this project!

Don't hate the player hate the game (admin)!

### You get redirected to a link as below everywhere if you see a telegram button:

https://t.me/spiderbot_if

#### Copy the url in browser, add the 's' i mention above and now visit:

https://t.me/s/spiderbot_if

Scroll until end, now execute below in browser console!

This script will grab all urls and open a new tab in your browser with all urls on the currrent page.

```js
var x = document.querySelectorAll("a");
var myarray = []
for (var i=3; i<x.length; i++){
var nametext = x[i].textContent;
var cleantext = nametext.replace(/\s+/g, ' ').trim();
var cleanlink = x[i].href;
myarray.push([cleantext,cleanlink]);
};
function make_table() {
    var table = '<table><thead><th>Emagnet Power!</th><th>';
   for (var i=3; i<myarray.length; i++) {
            table += '<tr><td>'+ myarray[i][3] + '</td><td>'+myarray[i][1]+'</td></tr>';
    };

    var w = window.open("");
w.document.write(table);
}
make_table()
```

or even better, print urls in current window and right click in console window and copy / paste! :)

```js
var urls = document.getElementsByTagName('a');
for (url in urls) {
    console.log ( urls[url].href );
}
```

You probably know it already, im lazy - no jquery needed - autoscroll to top/bottom of page by copy and paste in console:

```js
(function smoothscroll(){
    var currentScroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currentScroll > 0) {
         window.requestAnimationFrame(smoothscroll);
         window.scrollTo (0,currentScroll - (currentScroll/5));
    }
})();
```

### End




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

