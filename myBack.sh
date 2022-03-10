#!/usr/bin/bash

_USERNAME=""
_PASSWORD=""
_DB_NAME=""
_DIRDB_BACKUP=""

_CURR_DATETIME=$(date +%m-%d-%y-%H-%M-%S)

. myBack.cnf

helpText(){
cat <<ADDTEXT

<$0 Version 1.0.0>
Develope By Jeremiah Prasetyo

This tool can be uses to backup MySQL or MariaDB Database
The output is .sql file, you can re-import that file if the database broken or deleted.
Because this tool based on "mysqldump" and can send email notification, thus it need:
- Install MySQL or MariaDB Previously
- Fill the myBack.cnf for the email sender configuration

[Usage for backup:] 
$0 -u <username> -p <password> -dN <database-name> -dB <directory-backup>

[Example: ] 
$0 -u jepra -p 12345 -dN myDatabase -dB /home/jepra/

[Usage for help:]
$0 -h 
or 
$0 --help

Options
 -u, --username		The MySQL/MariaDB username
 -p, --password		The MySQL/MariaDB password
 -dN, --dbname		The exist database name
 -dB, --dirbackup	The directory where database will be backup
 -h, --help		To show this help

ADDTEXT
}

sendMail(){

email_body="From: $senderName <$emailSender>
To: $emailReceiver <$emailReceiver>
Subject: Success Backup DB

Hi, Success Backup DB"

curl -vvv --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
--mail-from "$emailSender" --mail-rcpt "$emailReceiver" \
--user "$emailSender:$password" --insecure \
--upload-file <(echo "$email_body")

}

dbBackup(){
mysqldump -u$_USERNAME -p$_PASSWORD $_DB_NAME > "$_DIRDB_BACKUP""$_DB_NAME"-"$_CURR_DATETIME".sql
}

while [[ "$1" == -* ]]; do
	case "$1" in
	-u|--username)
			shift
			_USERNAME="$1"
			;;
	-p|--password)
			shift
			_PASSWORD="$1"
			;;
	-dN|--dbname)	
			shift
			_DB_NAME="$1"
			;;
	-dB|--dirbackup)
			shift
			_DIRDB_BACKUP="$1"
			;;
	-h|--help)
			helpText
			exit 0
			;;
		
		--)
			shift
			break
			;;
	esac
	shift
done

if [[ ! -z "$_USERNAME" && ! -z "$_PASSWORD" && ! -z "$_DB_NAME" && ! -z "$_DIRDB_BACKUP" ]];
then

if [[ ! $_DIRDB_BACKUP == */ ]]; 
then 
_DIRDB_BACKUP="$_DIRDB_BACKUP""/"
dbBackup
else
dbBackup
fi

if [[ $? -eq 0 ]];
then
sendMail
fi

elif [[ -z "$_USERNAME" || -z "$_PASSWORD" || -z "$_DB_NAME" || -z "$_DIRDB_BACKUP" ]];
then
helpText
exit 1
fi
