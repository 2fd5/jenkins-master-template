terraform {
  required_providers {
    jenkins = {
      source = "taiidani/jenkins"
      version = "0.6.0"
    }
  }
}

provider jenkins {}

resource jenkins_folder foo_folder {
  name = "moduleFoo"
}

resource jenkins_job simple_job {
  name     = "${jenkins_folder.foo_folder.name}/BuildSimple"
  template = file("${path.module}/job.xml")

  parameters = {
    branch_spec = "*/main"
    script_path = "Jenkinsfile"
    description = "An example job created from Terraform"
    git_url = "https://github.com/2fd5/jenkins-master-template.git"
  }
}


resource jenkins_job foos_job {
  count = 5
  name     = "${jenkins_folder.foo_folder.name}/BuildFoos-${count.index}"
  template = file("${path.module}/job.xml")

  parameters = {
    branch_spec = "*/main"
    script_path = "Jenkinsfile"
    description = "An example job created from Terraform\ncount.index=${count.index}"
    git_url = "https://github.com/2fd5/jenkins-master-template.git"
  }
}
