FROM funkygibbon/ubuntu

MAINTAINER Ray Walker <hello@raywalker.it>

# install java
RUN apt-get update && \
    apt-get install -y \
    	openjdk-9-jre-headless && \
    apt-get clean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*