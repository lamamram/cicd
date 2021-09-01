# Instruction FROM : image parente de base
# Permet d'avoir un ensemble de commandes à dispo pour ajouter du contenu dans mon image
FROM centos:8

# Metadatas, pour donner des infos sur l'auteur, la version, description
LABEL maintainer="Pierre"
LABEL description="Image tomcat avec application intégrée"


# Instruction RUN : exécuter des commandes (Linux)
RUN yum install -y java-11-openjdk

RUN mkdir /opt/tomcat \
    && curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.70/bin/apache-tomcat-8.5.70.tar.gz \
    && tar -zxf apache-tomcat-8.5.70.tar.gz \
    && mv apache-tomcat-8.5.70/* /opt/tomcat/ \
    && rm -rf /apache-tomcat-8.5.70*

# Instruction WORKDIR, positionne le shell dans le répertoire désiré
WORKDIR /opt/tomcat/webapps

# Telechargement du code applicatif (war)
# TEst cache
ARG cache=yes
RUN curl -O -L https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war

# Instruction EXPOSE : rendre visible un port applicatif
EXPOSE 8080

# Instruction CMD : commande finale qui executer quand un conteneur sera instancié à partir de cette image
CMD ["/opt/tomcat/bin/catalina.sh", "run"] 