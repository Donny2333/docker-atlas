sed -i 's#http://deb.debian.org#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list
sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

apt update && apt install lsof

cd /data/atlas/apache-atlas-2.3.0

rm -rf logs
# rm -rf data

hbase/bin/start-hbase.sh

rm -rf solr/bin/solr-*.pid
rm -rf solr/server/solr/*_index_shard1_replica_n1

solr/bin/solr start -c -z 127.0.0.1:2181 -p 8983 -force

solr/bin/solr  create -c fulltext_index -force -d conf/solr/ 
solr/bin/solr  create -c edge_index -force -d conf/solr/   
solr/bin/solr  create -c vertex_index -force -d conf/solr/

python3 bin/atlas_start.py

tail -f logs/application.log
