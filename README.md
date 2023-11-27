# local-mediawiki

Run a local MediaWIki instance on your workstation/laptop using docker compose

# Getting Started

After checking out the repo, run the make recipe setup which will
create the required docker network using the make target 'create-net'
and the intialize a mediawiki container using the docker-compose-setup.yml
configuration.

```
$ make setup
```

Various environment values are configured in the .env file and are
referenced both in the Makefile and the two docker compose files
provided.

The only difference between the two docker compose files is the
line mapping LocalSettings.php into the MediaWiki container filesystem.
In the 'setup' variant this line (L25) is commented out in the other
it is not.

When MediaWiki starts it attempts to load LocalSettings.php and
if this is not found it goes into setup mode which allows you to
configure you wiki via a web interface:

```
http://localhost:80xx
```

The exact port used is specified in the .env file.  Many of us will
have various apps listeing on localhost:8080 or some variant of
this so a mechanism is provided tio allow you to customise this
port.

To configure the wiki you will need to specify database credentials.
The repo is setup to use 'root' with password 'MediaWiki-2023'.
The password can be customised in the .env file.

You will also need to provide a name for the database and a title
for the wiki and credentials for you to start with.  In my example
I used local-mediawiki as the database name and Local MediaWiki'
as the Title.

Once you have completed the setup process the site will download a
copy of the new LocalSettings.php file which you will need to save
into the top level directory of the repo. Then run:

```
make down
```

followed by:

```
make up
```

This last command will bring up the MediaWiki container configured
with your newly minted settoings file.

Be aware that if you run make setup after completing the setup
process you will clobber the database setup and will need to
reinitialise the installation, potentially using any data you
have stored in your wiki.

Scripts are provided in the root user folder on the DB container
to back up the database into the /bak folder which is mapped into
the repo as data/db-bak.

You can similarly back up the MediaWiki installation in the running
mediawiki container using the follwing commands:

```
make backup-mw
ls -l data/mw-bak
```






