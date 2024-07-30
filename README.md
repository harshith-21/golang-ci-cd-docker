# Golang + ci cd + docker

> As the title suggests, its a project to automate docker based deployments using jenkins

## **SETUP**

### Jenkins setup

I am using a RHEL8 machine, so the commands and setup will be done for that, you will find alternatives for those pretty easily

To install jenkins
```sh
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk
sudo yum install jenkins
sudo systemctl daemon-reload

# Start jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

> You will get a temporary password at `/var/lib/jenkins/secrets/initialAdminPassword` use that to login at `http://{{your_host_ip}}:8080` and then create appropriate user with password.

Then you can install community suggested plugins and then you will a dashboard page for jenkins


> will look something like this
![](images/Screenshot%202024-07-30%20at%2012.22.22 AM.png)


### Repo setup

Create a github repo, preferably a public one :) 

Now we will add that Jenkinsfile in that repo with a content for a simple pipeline. you can use content of jenkinsfile_init. Push that to repo.


### Configure jenkins to this repo

Select new Item in jenkins dashboard, give and name and select pipeline and hit ok

In that scroll to pipeline and select `Pipeline script from SCM`, select GIT as SCM as follows

![](images/Screenshot%202024-07-30%20at%2012.29.40 AM.png)

Now set repo url, credentials if private :)

Dont forget to change branch as applicable for your repo.

![](images/Screenshot%202024-07-30%20at%2012.31.21 AM.png)


Once you hit save, you will be able to run pipeline, and you will be able to see following if you hit the job that has been run

![](images/Screenshot%202024-07-30%20at%2012.34.57 AM.png)

### Docker installation

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
```


> Now we are pretty much done with setup

---

## **DEVELOPMENT**

Install go with

```sh
cd /opt/
wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
tar xzf go1.22.5.linux-amd64.tar.gz

# and adding following to .bashrc for for root user to access go, for jenkins we an export when needed
export PATH=$PATH:/opt/go/bin

# Also add user jenkins to docker group
sudo usermod -aG docker jenkins
```