# ELK Searchguard Stack on Docker Swarm

- based from repo: https://github.com/deviantony/docker-elk/tree/searchguard

## Feature Updates:

- java-1.8.0-openjdk installed on elasticsearch container for search-guard-tlstool to work
- search-guard-tlstool is used in elasticsearch container and generates ssl for elasticsearch and kibana
- update initialing ssl searchguard `sgadmin` with pem files!!
- root-da.pem is shared between elasticsearch and kibana containers

## Versions:

- ELK 6.4.2
- search guard 6
- search-guard-tlstool-1.5 https://github.com/floragunncom/search-guard-tlstool
- java-1.8.0-openjdk
- docker (v18.03)

**Note:** I currently use on GCE Ubuntu 18.04 LTS server with docker swarm, refer to https://github.com/cquan808/docker-swarm-gcepd.git for setup

## Quickstart

Change directory:
`cd docker-elk-searchguard/`

Update file `docker-stack.yml`

- update `ES_JAVA_OPTS` and `LS_JAVA_OPTS` to match your use case

Create a volume shared between elasticseach and kibana container:

`docker volume create --name ssl`

Update file: `elasticsearch/search-guard-tlstool-1.5/config/elk.yml`

- add your own docker swarm node dns name
- add your own docker swarm node ip
- edit dn to something more personal (optional but recommended)

Update file: `docker-elk-searchguard/elasticsearch/config/elasticsearch.yml`

- update dn here if changed in creating with searchguard tls tool in the step above

Build images for elasticsearch, kibana, and logstash:

`docker-compose build`

**Note:** if docker-compose is not installed: `apt-get install docker-compose`

Deploy Stack:

`docker stack deploy -c docker-stack.yml searchguard`

Get docker container name for elasticsearch `docker ps -a` and ssh into:

`docker exec -it <elasticsearch-container-name> /bin/bash`

**Note:** to generate new password for user: 

`plugins/search-guard-6/tools/hash.sh -p <new-password>`

a new password hash will be generated, replace in `elasticsearch/config/sg/sg_internal_users.yml` if you want to update (recommended for production)

**Note:** places to note if passwords are changed in `elasticsearch/config/sg/sg_internal_users.yml`:

- kibana --> `kibana/config/kibana.yml` (must be changed first before build deploying stack)
- logstash --> `logstash/pipeline/logstash.conf` (must be changed first before build and deploying stack)

Initiate searchguard:

`bin/startNode.sh`

Check elasticsearch health:

`curl http://localhost:9200/_searchguard/health`

Check elasticsearch index:

`curl http://localhost:9200/_cat/indices?pretty -u admin:admin`

After elk-searchguard is started, on a command prompt of your choice in your local computer (windows 10 for me) with gcloud sdk installed, run:

`gcloud compute ssh --zone=us-central1-f --project <your-gcloud-project-name> --ssh-flag="-L" --ssh-flag="80:localhost:80" <gce-server-name>`

Open a browser and enter kibana:

`localhost:80`

**Note:** unchanged user:password to login is `admin:admin`

