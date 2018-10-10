FROM ubuntu:14.04
RUN apt-get update && apt-get -y upgrade
RUN sudo apt-get install software-properties-common -y
RUN sudo apt-add-repository ppa:webupd8team/java -y
RUN sudo apt-get update -y
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
RUN sudo apt-get -y install oracle-java8-installer -y
RUN echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
RUN echo 'export JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /root/.bashrc
RUN apt-get install vim -y
RUN wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz
RUN tar xvf /apache-tomcat-7.0.53.tar.gz
RUN sed -i '/^[ \t]*<tomcat-users>/,/^[ \t]*<\/tomcat-users>/c\<tomcat-users>\n<role rolename="role1"\/>\n<role rolename="manager-gui"\/>\n<role rolename="manager-script"\/>\n<user username="tomcat" password="tomcat" roles="manager-gui,manager-script"\/>\n<user username="both" password="both" roles="tomcat,role1"\/>\n<user username="role1" password="role1" roles="role1"\/>\n<\/tomcat-users>' /apache-tomcat-7.0.53/conf/tomcat-users.xml
#deploying jar file
ADD initializr-generator/target/*.jar /usr/local/tomcat/webapps/
ADD initializr-docs/target/*.jar /usr/local/tomcat/webapps/
ADD initializr-web/target/*.jar /usr/local/tomcat/webapps/
ADD initializr-service/target/*.jar /usr/local/tomcat/webapps/
ADD initializr-actuator/target/*.jar /usr/local/tomcat/webapps/
# Expose the default tomcat port
EXPOSE 8097
