

USER := root
PASSWORD := MediWiki-2023
WIKI := local-mediawiki

my:
	mysql -u ${USER} -p${PASSWORD} ${WIKI}

backup:
	~/bin/backup.sh

dump:
	mysqldump -u ${USER} -p${PASSWORD} ${WIKI}

