ARG JENKINS_VERSION=2.261
FROM jenkins/jenkins:${JENKINS_VERSION}

USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

ARG JENKINS_USER=admin
ARG JENKINS_PASS=admin
ENV JENKINS_USER=${JENKINS_USER}
ENV JENKINS_PASS=${JENKINS_PASS}

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# For 2.x-derived images, you may also want to
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY jenkins-settings/executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY jenkins-settings/default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY --chown=jenkins:jenkins jobs/ /var/jenkins_home/jobs/

USER root

# Install additional packages here

# Drop back to the regular jenkins user - good practice
USER jenkins
