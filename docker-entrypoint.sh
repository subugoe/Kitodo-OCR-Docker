#!/bin/sh

[ -e "${KITODO_HOME}/config/modules.xml" ] \
    || unzip -n -d "${KITODO_HOME}" /tmp/kitodo_config.zip

[ -e "${KITODO_HOME}/modules" ] \
    || (mkdir -p "${KITODO_HOME}/modules" \
            && unzip -n -j -d "${KITODO_HOME}/modules" /tmp/kitodo_mods.zip)

# Database configuration
/bin/sed -i \
         "s,\(jdbc:mysql://\)[^/]*\(/.*\),\1${DB_ADDR}:${DB_PORT}\2," \
         ${CATALINA_HOME}/webapps/kitodo/WEB-INF/classes/hibernate.cfg.xml

# Elasticsearch configuration
/bin/sed -i \
         "s,^\(elasticsearch.host\)=.*,\1=${ELASTIC_ADDR}," \
         ${CATALINA_HOME}/webapps/kitodo/WEB-INF/classes/kitodo_config.properties

# Wait for database container
/tmp/wait-for-it.sh -t 0 ${DB_ADDR}:${DB_PORT}

# Initialize database if necessary
echo "SELECT 1 FROM user LIMIT 1;" \
    | mysql -h "${DB_ADDR}" -P "${DB_PORT}" -u kitodo --password=kitodo kitodo >/dev/null 2>&1 \
    || mysql -h "${DB_ADDR}" -P "${DB_PORT}" -u kitodo --password=kitodo kitodo < /tmp/kitodo.sql

# Script permissions and line endings
log "Setting permissions and fixing line endings for scripts..."
/bin/sed -i 's/\r$//' "${KITODO_HOME}/scripts/"*
chmod 777 "${KITODO_HOME}/scripts/"*

git clone https://github.com/subugoe/Operandi-Integration-Script.git "${KITODO_HOME}/Operandi-Integration-Script"
chmod 777 "${KITODO_HOME}/Operandi-Integration-Script/"*
mv /Example_Workflow.* "${KITODO_HOME}/diagrams/"

# Run CMD
"$@"
