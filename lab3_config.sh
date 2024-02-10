#!/bin/bash

# Config for core-site.xml
sed -i '/<configuration>/a\
  <property>\n\
    <name>fs.defaultFS</name>\n\
    <value>hdfs://localhost:9000</value>\n\
  </property>' \
$HADOOP_HOME/etc/hadoop/core-site.xml

# Config for hdfs-site.xml 
# Since we are running Hadoop in only one machine, a replication factor >1 does not make sense 
sed -i '/<configuration>/a\
  <property>\n\
    <name>dfs.replication</name>\n\
    <value>1</value>\n\
  </property>' \
$HADOOP_HOME/etc/hadoop/hdfs-site.xml

# Config for mapred-site.xml 
sed -i '/<configuration>/a\
  <property>\n\
    <name>mapreduce.framework.name</name>\n\
    <value>yarn</value>\n\
  </property>\n\
  <property>\n\
    <name>mapreduce.application.classpath</name>\n\
    <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>\n\
  </property>' \
$HADOOP_HOME/etc/hadoop/mapred-site.xml

# Config for yarn-site.xml
sed -i '/<configuration>/a\
  <property>\n\
    <description>The hostname of the RM.</description>\n\
    <name>yarn.resourcemanager.hostname</name>\n\
    <value>localhost</value>\n\
  </property>\n\
  <property>\n\
    <name>yarn.nodemanager.aux-services</name>\n\
    <value>mapreduce_shuffle</value>\n\
  </property>\n\
  <property>\n\
    <name>yarn.nodemanager.env-whitelist</name>\n\
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_HOME,PATH,LANG,TZ,HADOOP_MAPRED_HOME</value>\n\
  </property>' \
$HADOOP_HOME/etc/hadoop/yarn-site.xml
