# MOST USEFUL COMMAND LINE (CLI)

Bash/Sh
```
if [ -z $VAR ]; then
     echo "VAR is empty"
else
    echo "VAR=$VAR"
fi
```
All conditions: https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

```
# find some binary bytes 
grep -rnw ~/.m2 -e '\u0000'
Binary file /home/ogavliuk/.m2/repository/io/cucumber/messages/resolver-status.properties matches
```


Services running & logs

```
# systemctl list-units --type=service --state=active

# journalctl -f -u <service-name>
```

Webhook dumper URL
https://gpg8a23o5i.execute-api.eu-west-1.amazonaws.com/default/webhook-dumper

Tomcat app

Reload/Start/Stop app
Use curl or whatever command line tool you like to fetch the URl <yourserver>/manager/text/reload?path=/<context_path>:
```
curl --user admin:barabashka1 http://localhost:8080/manager/text/list
curl --user admin:barabashka1 http://localhost:8080/manager/text/reload?path=/ibank
curl --user admin:barabashka1 http://localhost:8080/manager/text/start?path=/ibank
curl --user admin:barabashka1 http://localhost:8080/manager/text/stop?path=/ibank
```

Rabbit MQ
```
echo "Hello world!" | rabbitmqadmin publish exchange=amq.default routing_key=my_queue
```

Keytool

create keystore from pem files
```

```

Enable / Extend linux swap
```
sudo swapoff /swapfile
sudo rm /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo nano /etc/fstab
/swapfile none swap sw 0 0
```

Tomcat add memory
create bin/setenv.sh
```
CATALINA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8
-server -Xms1536m -Xmx1536m
-XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m
-XX:MaxPermSize=256m -XX:+DisableExplicitGC"
```
Tomcat users
```
vi conf/tomcat-users.xml

<role rolename="manager-gui"/>
<user username="admin" password="****" roles="manager-gui,manager-script,admin"/>
```
Run Tomcat at start
http://www.linuxandubuntu.com/home/how-to-run-tomcat-server-at-startup-on-ubuntu-server


GIT
    Ignore windows line ending
```
git config --global core.autocrlf true
```
    cache password for 300 sec (5 min)
```
git config credential.helper 'cache --timeout=300'
```
    archive in tgz some branch
```
git archive --format=tgz -o ./tas-server-20181113.tgz develop
```
    chmod for git files
```
git update-index --chmod=+x path/to/file
```

Get exact tag on this revision OR branch if there is no exact tag
```
git describe --tags --exact-match 2>/dev/null || git symbolic-ref -q --short HEAD
```

Remove locally branches not available on server
```
git remote prune origin
git branch --merged
# drop all except master or other you really need by "git branch -d <branch-already-merged>"
git branch --v | grep "\[gone\]" | awk '{print $1}' | xargs git branch -D
```


OpenSSL
get remote server SSL certs
```
openssl s_client -connect {HOSTNAME}:{PORT} -showcerts
```

Get public key (in ssh-format) from private key
```
ssh-keygen -y -f ~/.ssh/some.key
```

Create new key
```
ssh-keygen -f ~/.ssh/some_key -C 20190328_some_key
```

Show certificate info
```
openssl x509 -in cert.crt -text -noout
```

Random 32-byte base64 string
```
openssl rand -base64 32
```

More: https://www.sslshopper.com/article-most-common-openssl-commands.html

rsync
```
# archive mode with progress
rsync -aP source/ destination/

# dry run and delete if deleted in source
rsync -anv --delete source destination
rsync -a --delete source destination

# remote server w/ alternative key
rsync -aP -e "ssh -i $HOME/.ssh/aws-gavliuk.pem" ./source/dir ubuntu@ec2-XX-XX-XX-XX.eu-west-1.compute.amazonaws.com:./destinarion/dir
```

Listened ports
```
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo lsof -i:22 ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here

# Remore port is open?
nc -zvw10 192.168.0.1 22
```

Postgres

Connection stats:
```
SELECT * FROM pg_settings WHERE name = 'max_connections';

select * from pg_stat_activity;

SELECT s.client_addr , s.usename, count(*) FROM pg_stat_activity s group by s.client_addr , s.usename;
```

Dump:
```
pg_dump -U user -h hostname 
```

Run docker postgres as for developer:
```
docker volume create pgdata
docker run --name postgres -e POSTGRES_PASSWORD=12345 -v pgdata:/var/lib/postgresql/data -p 5432:5432  -d postgres
sudo apt install postgresql-client
psql -U postgres -h localhost
postgres=#
```


```
# restart to reset all connections to this db
sudo service postgresql restart
sudo su -l postgres
psql
# drop database yourbasename;
```

```
CREATE DATABASE yourdbname;
CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';
ALTER USER youruser WITH PASSWORD 'new_password';
```
grant to all db
```
create user :usr with encrypted  password ':psw'
GRANT ALL PRIVILEGES ON DATABASE como_dealers_db TO :usr;
grant usage on schema como_connect to :usr;
grant all privileges on all tables in schema como_connect to :usr;
grant :user_who_own_tabels to :usr;
```
or grant to some schema
```
\c yourdbname;
DROP SCHEMA yourschema CASCADE;
CREATE SCHEMA yourschema AUTHORIZATION youruser;
\dn # schema list
```
Change postgres user password
```
ALTER USER user_name WITH PASSWORD 'new_password';
```

Largest tables
```
SELECT *, pg_size_pretty(total_bytes) AS total
    , pg_size_pretty(index_bytes) AS INDEX
    , pg_size_pretty(toast_bytes) AS toast
    , pg_size_pretty(table_bytes) AS TABLE
  FROM (
  SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes FROM (
      SELECT c.oid,nspname AS table_schema, relname AS TABLE_NAME
              , c.reltuples AS row_estimate
              , pg_total_relation_size(c.oid) AS total_bytes
              , pg_indexes_size(c.oid) AS index_bytes
              , pg_total_relation_size(reltoastrelid) AS toast_bytes
          FROM pg_class c
          LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
          WHERE relkind = 'r'
  ) a
) a order by total_bytes desc;
```

Mysql
```
CREATE DATABASE newdb;
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON  newdb.* TO 'newuser'@'localhost';
```

Tables size:
```
SELECT 
     table_schema as `Database`, 
     table_name AS `Table`, 
     round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
ORDER BY (data_length + index_length);
```

Import large dump file in MySQL:

```
mysql -u root -p
set global net_buffer_length=1000000; --Set network buffer length to a large byte number
set global max_allowed_packet=1000000000; --Set maximum allowed packet size to a large byte number
SET foreign_key_checks = 0; --Disable foreign key checking to avoid delays,errors and unwanted behaviour
source file.sql --Import your sql dump file
SET foreign_key_checks = 1; --Remember to enable foreign key checks when procedure is complete!

SHOW VARIABLES LIKE 'max_allowed_packet';
```


Linux commons
```
sudo update-alternatives --config editor
```

Disabling SELinux (CentOs, etc) file protection (for web-server access, etc)
https://www.thegeekdiary.com/how-to-disable-or-set-selinux-to-permissive-mode/
```
# vi /etc/selinux/config
...
SELINUX=disabled
...


# setenforce 0
```

Shell scripting (sh) 
https://www.shellscript.sh/test.html

Gradle 
Self-update wrapper
```
./gradlew wrapper --gradle-version 5.2.1
```

Node.js
On amazon linux: https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 10.15.3
node -v
```

DOCKER
```
# clean docker
docker system prune -a -f
```

Backup Docker 'foobar' Volume :
```
$ mkdir -p backup
$ docker run --rm -v foobar:/volume -v `pwd`/backup:/backup busybox sh -c 'cp -r /volume /backup'
```

Fix network errors
```
docker-compose up --force-recreate
```

KUBERNETES / k8s

Access remote cluster: https://acloudguru.com/hands-on-labs/configuring-kubectl-to-access-a-remote-cluster 

```
# View config
kubectl config view

# Pods
kubectl get pods -A

kubectl auth can-i create pods
```


AWS
Who I am?
```
aws sts get-caller-identity
```

VIM
Solves problem with up-down-left-right: A B C D
```
$ echo "set nocompatible" >> ~/.vimrc
```

History with date-time (not works, must be in bash_rc to store in such format)
```
$ export HISTTIMEFORMAT="%d/%m/%y %T "
$ history
```

Ubuntu install nvidia


	sudo ubuntu-drivers autoinstall


