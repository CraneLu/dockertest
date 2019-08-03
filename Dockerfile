FROM ccr.ccs.tencentyun.com/ffy-base/centos7-jdk1.8:v1

# USER root

# 变量
ENV WEBDEV_ROOT_PATH /www
ENV SERVER_PORT=10000
ENV APP_NAME=dockerdemo
ENV SITE_ROOT_FOLDER=agent.test.fangfangyun.cn-${SERVER_PORT}
ENV SPRING_PROFILES_ACTIVE=test
ENV JAR_FILE_NAME=${APP_NAME}-0.0.1-SNAPSHOT
ENV JVMARGS=" -Xms512m -Xmx512m -Xmn128m -Xss256k -Djava.io.tmpdir=${TMP_DIR} -Dlogback.path.port=${SERVER_PORT}"
    # -Dsun.misc.URLClassPath.disableJarChecking=true -Xdebug -Dcom.sun.management.jmxremote -XX:+PrintTenuringDistribution -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCApplicationConcurrentTime -XX:+PrintGCApplicationStoppedTime -Djava.awt.headless=true

    ##################################################################################

ENV JARFILE=${WEBDEV_ROOT_PATH}/${SITE_ROOT_FOLDER}/${JAR_FILE_NAME}.jar
ENV TMP_DIR=${WEBDEV_ROOT_PATH}/tmp/${APP_NAME}-${SERVER_PORT}/
ENV LOG_FOLDER=${WEBDEV_ROOT_PATH}/logs/
ENV RUNNING_LOG=${LOG_FOLDER}/runninglogs
ENV GC_LOG=${LOG_FOLDER}/tomcat/gc/gc_${APP_NAME}_${SERVER_PORT}.log


#项目文件
RUN mkdir -p ${WEBDEV_ROOT_PATH}/${SITE_ROOT_FOLDER} \
    && mkdir -p ${WEBDEV_ROOT_PATH}/logs/log \
    && mkdir -p ${WEBDEV_ROOT_PATH}/logs/runninglogs \
    && mkdir -p ${WEBDEV_ROOT_PATH}/logs/tomcat/accesslog \
    && mkdir -p ${WEBDEV_ROOT_PATH}/logs/tomcat/gc \
    && mkdir -p ${WEBDEV_ROOT_PATH}/tmp/${APP_NAME}-${SERVER_PORT} \
    && mkdir -p ${WEBDEV_ROOT_PATH}/pid/${APP_NAME}-${SERVER_PORT}

#COPY fangcloud-api-frontend/src/main/script/test/dbcfg.conf /www/webdev/cfgfiles/webapi.yun.test.fang.com
COPY ${JAR_FILE_NAME}.jar ${WEBDEV_ROOT_PATH}/${SITE_ROOT_FOLDER}

EXPOSE ${SERVER_PORT}

ENTRYPOINT java -jar ${JARFILE} -Xloggc:${GC_LOG} --spring.profiles.active=${SPRING_PROFILES_ACTIVE} --server.port=${SERVER_PORT}
#ENTRYPOINT ["echo","ok"]
