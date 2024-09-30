# Prerequisites

Having Docker and Docker Desktop installed on your local machine

## Build the image

```bash
docker build -t big-data .
```

## Run the image in iterative mode

```bash
docker run -it --rm big-data
```

## (Optional) Build the .jar file

```bash
mvn clean package
```

## Activate spark master

```bash
$SPARK_HOME/sbin/start-master.sh
```

## Inspect the url of the spark master

```bash
cat /opt/spark/logs/spark--org.apache.spark.deploy.master.Master-1-***********.out
```

## Activate spark worker

```bash
$SPARK_HOME/sbin/start-worker.sh spark://***********:7077
```

## Run spark application

```bash
spark-submit --class org.bigData.MovieRecommendation.MovieRecommendation --master spark://***********:7077 /app/target/big-data-1.0.0.jar /movies.txt
```

## Inspect the output

```bash
hadoop fs -cat /movies/output/part-00000
```
