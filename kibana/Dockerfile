ARG ELK_VERSION

# https://github.com/elastic/kibana-docker
FROM docker.elastic.co/kibana/kibana-oss:${ELK_VERSION}

COPY config/kibana.yml config/kibana.yml

# Search Guard plugin
ARG ELK_VERSION
ARG SG_VERSION_KIBANA
RUN kibana-plugin install https://repo1.maven.org/maven2/com/floragunn/search-guard-kibana-plugin/${ELK_VERSION}-${SG_VERSION_KIBANA}/search-guard-kibana-plugin-${ELK_VERSION}-${SG_VERSION_KIBANA}.zip

USER root

RUN chown -R kibana config/ && \
    chmod -R 700 config
# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>
