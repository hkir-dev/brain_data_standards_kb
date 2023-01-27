#!/bin/sh
echo "set read only = ${NEOREADONLY} then launch neo4j service"
sed -i s/read_only=.*/read_only=${NEOREADONLY}/ ${NEOSERCONF} && \

echo 'Allow new neo4j2owl plugin to make changes..'
echo 'dbms.security.procedures.unrestricted=ebi.spot.neo4j2owl.*,apoc.*' >> ${NEOSERCONF}
#echo 'dbms.security.procedures.whitelist=ebi.spot.neo4j2owl.*,apoc.*' >> ${NEOSERCONF}

if [ -n "${BACKUPFILE}" ]; then
  if [ ! -f /data/databases/neo4j/neostore ]; then
    if [ ! -f /backup/neo4j.dump ]; then
      echo 'Restore KB from archive backup'
      cd /backup/
      wget http://data.virtualflybrain.org/archive/${BACKUPFILE}
      cd -
    fi
    if [ -f /backup/neo4j.dump ]; then
      echo 'Resore KB from given backup'
      /var/lib/neo4j/bin/neo4j-admin load --from=/backup/neo4j.dump --verbose --force
    fi
  fi
fi

echo -e '\nSTARTING VFB KB SERVER\n' >> /var/lib/neo4j/logs/query.log

#if [ -z "$(ls -A /var/lib/neo4j/import)" ]; then
#  echo "Transfering CSVs to import"
#  cp -R $CSV_IMPORTS/. /var/lib/neo4j/import
#fi

#Output the query log to docker log:
tail -f /var/lib/neo4j/logs/query.log >/proc/1/fd/1 &
exec /docker-entrypoint.sh neo4j
