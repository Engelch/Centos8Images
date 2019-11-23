FROM centos:8

RUN dnf upgrade -y &&\
	dnf install -y epel-release &&\
	dnf install -y tmux bind-utils net-tools nmap-ncat unzip vim iftop iotop psmisc telnet htop zip gawk figlet rsync nmap ncdu lsof curl mariadb postgresql redis &&\
	dnf clean  all
