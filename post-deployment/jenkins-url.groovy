import jenkins.model.JenkinsLocationConfiguration
def jlc = jenkins.model.JenkinsLocationConfiguration.get()
def url = System.getenv('_JENKINS_URL')
jlc.setUrl(url)
