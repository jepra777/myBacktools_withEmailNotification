# myBacktools_withEmailNotification
Develope By Jeremiah Prasetyo
This tool can be uses to backup MySQL or MariaDB Database The output is .sql file, you can re-import that file if the database broken or deleted. Because this tool based on "mysqldump" and can send email notification, thus it need: - Install MySQL or MariaDB Previously - Fill the myBack.cnf for the email sender configuration

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
