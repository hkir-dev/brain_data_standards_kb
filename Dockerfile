FROM virtualflybrain/docker-vfb-neo4j:4.2-enterprise

VOLUME /input
ENV CSV_IMPORTS=/input/dumps/csv_imports
ENV BACKUP_FOLDER=/backup

ENV NEOREADONLY=true

ENV BACKUPFILE="neo4j.dump"

# Log4J CVE-2021-44228 vulnerability Mitigation for Neo4j
ENV NEO4J_dbms_jvm_additional="-Dlog4j2.formatMsgNoLookups=true -Dlog4j2.disable.jmx=true"
ENV LOG4J_FORMAT_MSG_NO_LOOKUPS=true

# from env.list
ENV NEO4J_AUTH=neo4j/neo
ENV NEO4J_dbms_read__only=true
ENV NEO4J_dbms_memory_heap_maxSize=3G
ENV NEO4J_dbms_memory_heap_initial__size=1G
ENV NEO4J_dbms_security_procedures_unrestricted=ebi.spot.neo4j2owl.*,apoc.*
ENV NEO4J_dbms_directories_import=import
ENV NEO4J_dbms_security_allow_csv_import_from_file_urls=true
ENV NEO4J_dbms_connector_bolt_listen__address=:7686
ENV NEO4J_dbms_connector_bolt_advertised__address=:7686

RUN apt-get -qq update || apt-get -qq update && \
apt-get -qq -y install tar gzip curl wget

COPY loadKB.sh /opt/VFB/
# ADD $CSV_IMPORTS /var/lib/neo4j/import
ADD neo4j2owl.jar /var/lib/neo4j/plugins/neo4j2owl.jar

RUN mkdir $BACKUP_FOLDER
COPY /backup $BACKUP_FOLDER

###### APOC TOOLS ######
# ENV APOC_VERSION=3.3.0.1
ENV APOC_VERSION=4.2.0.1
ARG APOC_JAR=https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$APOC_VERSION/apoc-$APOC_VERSION-all.jar
ENV APOC_JAR ${APOC_JAR}
RUN wget $APOC_JAR -O /var/lib/neo4j/plugins/apoc.jar

RUN chmod +x /opt/VFB/loadKB.sh

ENTRYPOINT ["/opt/VFB/loadKB.sh"]
