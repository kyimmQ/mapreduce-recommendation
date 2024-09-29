# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenJDK, wget, and other necessary tools
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    pdsh \
    ssh \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Install Hadoop
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop

# Install Spark
RUN wget https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz && tar xvf spark-3.5.3-bin-hadoop3.tgz
# Set Hadoop environment variables
RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -xzf hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && rm hadoop-${HADOOP_VERSION}.tar.gz


RUN mv spark-3.5.3-bin-hadoop3 /opt/spark

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin




ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . .

RUN hadoop fs -put ./movies.txt /movies.txt

# $SPARK_HOME/sbin/start-master.sh
# spark://af2034e3f498:7077
# hadoop fs -cat /movies/output/part-00000


# spark-submit --class org.bigData.MovieRecommendation.MovieRecommendation --master spark://af2034e3f498:7077 /app/target/big-data-1.0.0.jar /movies.txt
# 
# CMD ["spark-submit", "--class", "MovieRecommendationSystem.MovieRecommendationsWithJoin", "--master", "spark://myserver100:7077",  "/app/target/big-data-1.0.0.jar", "/movies.txt"]