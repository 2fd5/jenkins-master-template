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

resource jenkins_job foo_job {
  name     = "${jenkins_folder.foo_folder.name}/BuildFoo"
  template = file("${path.module}/job.xml")

  parameters = {
    branch_spec = "*/main"
    script_path = "Jenkinsfile"
    description = "An example job created from Terraform"
    git_url = "https://github.com/2fd5/jenkins-master-template.git"
  }
}
