#!/bin/bash


function menu() {
clear
#echo ' ---------------------'
#echo '| Mehmet Install Tool |'
#echo ' ---------------------'

echo '
   _____         .__                    __ /\        .___                 __         .__  .__      __                .__   
  /     \   ____ |  |__   _____   _____/  |)/ ______ |   | ____   _______/  |______  |  | |  |   _/  |_  ____   ____ |  |  
 /  \ /  \_/ __ \|  |  \ /     \_/ __ \   __\/  ___/ |   |/    \ /  ___/\   __\__  \ |  | |  |   \   __\/  _ \ /  _ \|  |  
/    Y    \  ___/|   Y  \  Y Y  \  ___/|  |  \___ \  |   |   |  \\___ \  |  |  / __ \|  |_|  |__  |  | (  <_> |  <_> )  |__
\____|__  /\___  >___|  /__|_|  /\___  >__| /____  > |___|___|  /____  > |__| (____  /____/____/  |__|  \____/ \____/|____/
        \/     \/     \/      \/     \/          \/           \/     \/            \/
'
echo ' '
PS4='Maak uw keuze: '
options=("Installeer Webserver" "Installeer Nextcloud" "Installeer Fail2Ban" "Configureer Apache" "Configureer Nginx" "Configureer Trusted Domain" "Configureer PHP" "Firewall Aanpassen" "Beëindig Script")
select opt in "${options[@]}"
do
    case $opt in
        "Installeer Webserver")
        clear
        echo 'Wilt u de webserver installeren? (j/n)'
        read answer0
        if [ "$answer0" != "${answer0#[Jj]}" ] ;then
        clear
        echo "Wilt u apache of nginx installeren (Apache/Nginx)?"
        read answer1
            if [ "$answer1" == "Apache" ] ;then
            echo "De Apache server wordt geïnstalleerd"
            sudo apt install net-tools
                            clear
                sudo apt install apache2 libapache2-mod-php7.4 openssl php-imagick php7.4-common php7.4-curl php7.4-gd php7.4-imap php7.4-intl pmbstring php7.4-mysql php7.4-pgsql php-ssh2 php7.4- sqlite3 php7.4-xml php7.4-zip
                sudo apt install apache2
                sudo apt install php
                sudo apt install mariadb-server
                sudo mysql_secure_installation
            clear
            echo  'De Apache server is geïnstalleerd. (Druk op ENTER om door te gaan...)'
            read PAUSE
            menu
            else if [ "$answer1" == "Nginx" ] ;then
                sudo apt install imagemagick php-imagick php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl  php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp
                sudo apt install mariadb-server
                sudo mysql_secure_installation
                sudo apt install nginx -y
                sudo apt install mariadb-server
                sudo mysql_secure_installation
                sudo systemctl start nginx
                sudo systemctl enable nginx
            clear
            echo "Nginx is geïnstalleerd (Druk op ENTER om door te gaan...)"
            read PAUSE
            menu
            else 
            echo "Er ging iets mis (Druk op ENTER om door te gaan...)"
            clear
            menu
            fi       
            fi   
        fi
            ;;
        "Installeer Fail2Ban")
                    clear
                    echo 'Wilt u de Fail2Ban installeren (j/n)?'
                    read answer7
                    if [ "$answer7" != "${answer7#[Jj]}" ] ;then
                    clear
                    sudo apt-get install fail2ban
                    #herstel
                    sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
                    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
                    sudo systemctl enable fail2ban
                    sudo systemctl start fail2ban
                    sudo systemctl status fail2ban.service
                    sudo fail2ban-client status
                    sudo fail2ban-client status sshd
                    clear
                    sudo systemctl status fail2ban.service
                    echo ' ' 
                    echo 'Fail2Ban in geïnstalleerd (Druk op ENTER om verder te gaan.)'
                    read ENTER
                    menu
                    else if [ "$answer7" != "${answer7#[Nn]}" ] ;then
                    menu
                    else
                    echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
                    menu
                    
                    fi
                    fi
        ;;
        "Configureer Apache")
        clear
        echo 'Wilt u de Apache Server installeren? (j/n)'
        read answer2
        if [ "$answer2" != "${answer2#[Jj]}" ] ;then
            sudo systemctl stop apache2.service
            sudo nano /etc/apache2/sites-available/nextcloud.conf
            sudo a2ensite nextcloud.conf
            sudo a2enmod rewrite headers env dir mime setenvif ssl
            sudo chmod 775 -R /var/www/nextcloud/
            sudo chown www-data:www-data /var/www/nextcloud/ -R
            sudo systemctl restart apache2.service
            clear
            echo 'Ápache is ingesteld'
            read PAUSE
            menu
        else if [ "$answer2" != "${answer2#[Nn]}" ] ;then 
            menu
        else
            echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
            menu
        fi
        fi
        ;;
        "Configureer Nginx")
        clear
        echo 'Wilt u de Nginx Server installeren? (j/n)'
        read answer2
        if [ "$answer2" != "${answer2#[Jj]}" ] ;then
            sudo nano /etc/nginx/conf.d/nextcloud.conf
            sudo nano /etc/nginx/nginx.conf
            sudo chown www-data:www-data /usr/share/nginx/nextcloud/ -R
            clear
            echo "Configureer het onderdeel SQL voor Nginx"
            read PAUSE
            sudo mysql -u root -p
            sudo nginx -t
            clear
            echo 'Configuratie SQL is voltooid' 
            read PAUSE
            menu
            clear
            echo 'Nginx is ingesteld (Druk op de knop ENTER om door te gaan)'
            read PAUSE
        else if [ "$answer2" != "${answer2#[Nn]}" ] ;then 
            menu
            else
            echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
            menu
            fi
        fi
        ;;
        "Installeer Nextcloud")
        clear
        echo 'Wilt u de Nextcloud installeren? (j/n)'
        read answer3
        if [ "$answer3" != "${answer3#[Jj]}" ] ;then
            sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
            clear
            sudo unzip nextcloud-21.0.2.zip -d /var/www/nextcloud/
            clear
            echo 'Nextcloud is geïnstalleerd (Druk op de knop ENTER om door te gaan)'
            read PAUSE
            menu
        else if [ "$answer3" != "${answer3#[Nn]}" ] ;then 
            menu
        else
            echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
            menu
        fi
        fi
        ;;
        "Configureer Trusted Domain")
        clear
                echo 'Wilt u configureer trusted domains? (j/n)'
        read answer4
        if [ "$answer4" != "${answer4#[Jj]}" ] ;then
                clear
                echo 'Wilt u de trusted domain instellen voor Apache of Nginx (Apache/Nginx)?'
                read answer5
                if [ "$answer5" == "Apache" ] ;then
                    sudo systemctl stop apache2.service
                    sudo nano /var/www/nextcloud/config/config.php
                    sudo systemctl start apache2.service
                    clear
                    echo 'Apache is geconfigureerd (Druk op de knop ENTER om door te gaan)'
                    read ENTER
                    menu
                else if [ "$answer5" == "Nginx" ] ;then
                    sudo systemctl stop nginx.service
                    sudo nano /usr/share/nginx/nextcloud/config/config.php
                    sudo systemctl start nginx.service
                    clear
                    echo 'Nginx is succesvol geconfigureerd (Klik op de knop ENTER om door te gaan)'
                    read ENTER
                    menu
                else
                    echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
                    menu
                fi
                fi
            clear
            echo 'Nextcloud is geïnstalleerd (Druk op de knop ENTER om door te gaan)'
            read PAUSE
            clear
            menu
        else if [ "$answer4" != "${answer4#[Nn]}" ] ;then 
            menu
        else
                    echo "Er is iets misgegaan (Druk op ENTER om door te gaan...)"
                    menu
        fi
        fi            
        ;;
        "Configureer PHP")
        clear
        echo "Wilt u php configureren? (j/n)"
        read answer6
                if [ "$answer6" != "${answer6#[Jj]}" ] ;then
                    sudo nano /etc/php/7.4/cli/php.ini
                clear
                      echo 'PHP is geconfigureerd (Druk op de knop ENTER om door te gaan)'
                      read ENTER
                      clear
                      menu
                else if [ "$answer6" != "${answer6#[Nn]}" ] ;then
                    menu
                else
            clear
                echo "Er is iet misgegaan (Druk op de knop ENTER om door te gaan...)"
                read ENTER
                clear
                menu
    fi
    fi
            ;;
        "Firewall Aanpassen")
        clear
        echo "Wilt u de Firewall aanpassen? (j/n)"
        read answer9
                if [ "$answer9" != "${answer9#[Jj]}" ] ;then
                    
                    sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
                    sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
                    clear
                    echo 'Firewall is aangepast (Druk op de knop ENTER om door te gaan)'
                    read ENTER
                    menu
                else if [ "$answer6" != "${answer6#[Nn]}" ] ;then
                    clear
                    menu
                else
            clear
                echo "Er is iet misgegaan (Druk op de knop ENTER om door te gaan...)"
                read ENTER
                clear
                menu
    fi
    fi
        ;;
        "Beëindig Script")
            clear
            exit
            ;;
        *) clear
        echo "U heeft iets verkeerd ingevoerd: $REPLY"
        echo "Er ging iets mis (Druk op ENTER om door te gaan)"
        read PAUSE
        menu
        ;;
    esac
done
}

#Start Menu (Function Menu)
clear
menu