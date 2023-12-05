echo " */5 * * * * "$(realpath check-website-for-updates.sh) | crontab -
echo "Per disinstallare il cronjob modificare il crontab con"
echo "EDITOR=nano crontab -e"
