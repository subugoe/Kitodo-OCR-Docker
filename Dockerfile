# Use the latest Ubuntu as the base image
FROM tomcat:9-jdk14

# Set ARG and ENV for Kitodo
ARG KITODO_HOME=/usr/local/kitodo
ENV KITODO_VERSION="3.6.3"
ENV KITODO_VERSION_="3-6-3"

ENV KITODO_HOME ${KITODO_HOME}
ENV KITODO_VERSION ${KITODO_VERSION}

# Environment variables for database and Elasticsearch addresses
ENV DB_ADDR=localhost
ENV DB_PORT=3306
ENV ELASTIC_ADDR=localhost

# Copy necessary files to the image
COPY docker-entrypoint.sh /
COPY Example_Workflow.bpmn20.xml /
COPY Example_Workflow.svg /

# Set the entry point
ENTRYPOINT ["/docker-entrypoint.sh"]

# Set the working directory
WORKDIR /tmp

# Update package lists and install necessary packages
RUN apt-get -q update \
  && apt-get install -y docker.io \
  && apt-get -q install -y --no-install-recommends zip wget git curl mariadb-client unzip \
  && rm -rf /var/lib/apt/lists/*

# Download Kitodo and configure Tomcat
RUN wget -q https://github.com/kitodo/kitodo-production/releases/download/kitodo-production-${KITODO_VERSION}/kitodo_${KITODO_VERSION_}_config_modules.zip -O kitodo_config.zip \
  && wget -q https://github.com/kitodo/kitodo-production/releases/download/kitodo-production-${KITODO_VERSION}/kitodo_${KITODO_VERSION_}.sql -O kitodo.sql \
  && wget -q https://github.com/kitodo/kitodo-production/releases/download/kitodo-production-${KITODO_VERSION}/kitodo_${KITODO_VERSION_}_sbom.json -O kitodo_sbom.json \
  && wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
  && wget -q https://github.com/kitodo/kitodo-production/releases/download/kitodo-production-${KITODO_VERSION}/kitodo-${KITODO_VERSION}.war -O ${CATALINA_HOME}/webapps/kitodo.war \
  && unzip -d ${CATALINA_HOME}/webapps/kitodo ${CATALINA_HOME}/webapps/kitodo.war \
  && rm -f ${CATALINA_HOME}/webapps/kitodo.war \
  && chmod +x wait-for-it.sh \
  && chmod +x /docker-entrypoint.sh

# Install Nextflow
RUN curl -s https://get.nextflow.io | bash \
  && mv nextflow /usr/local/bin/

# Expose port 8080 for Tomcat
EXPOSE 8080

# Run Tomcat
CMD catalina.sh run
