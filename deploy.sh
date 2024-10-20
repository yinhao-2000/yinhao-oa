mvn clean package
# 参考 https://blog.csdn.net/qq_35086941/article/details/115723853
java_process_id=`ps -ef | grep service-oa.jar | grep -v grep | awk '{print $2}'`
kill -9 $java_process_id
nohup java -Dspring.config.location=file:/root/application-dev.yml service-oa/target/service-oa.jar &
