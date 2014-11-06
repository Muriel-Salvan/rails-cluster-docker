FROM centos:centos6
MAINTAINER Darin London <darin.london@duke.edu>

RUN ["/usr/bin/yum", "clean", "all"]
RUN ["/usr/bin/yum", "distro-sync", "-q", "-y", "--nogpgcheck"]
RUN ["/usr/bin/yum", "update", "-q", "-y","--nogpgcheck"]
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "gcc","gcc-c++", "glibc-static", "which", "zlib-devel", "readline-devel", "libcurl-devel", "tar"]
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "openssl", "openssl-devel"]
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "unzip", "bzip2", "wget"]

#shellshocked!
RUN ["/usr/bin/yum", "update", "-y", "--nogpgcheck", "bash"]
RUN ["mkdir", "-p", "/root/installs"]
WORKDIR /root/installs
RUN ["wget", "http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"]
RUN ["rpm", "-ivh", "/root/installs/epel-release-6-8.noarch.rpm"]
RUN ["rm", "/root/installs/epel-release-6-8.noarch.rpm"]

#ruby
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "libyaml", "libyaml-devel"]
RUN ["mkdir", "-p", "/root/installs"]
WORKDIR /root/installs
RUN ["wget", "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz"]
RUN ["tar", "-zxf", "ruby-2.1.2.tar.gz"]
WORKDIR /root/installs/ruby-2.1.2
RUN ["./configure", "--prefix=/usr/local", "--enable-shared", "--disable-install-doc"]
RUN ["make"]
RUN ["make", "install"]
WORKDIR /root/installs/ruby-2.1.2/ext/readline
RUN ["/usr/local/bin/ruby", "extconf.rb"]
RUN ["make"]
RUN ["make", "install"]
WORKDIR /root/installs/ruby-2.1.2/ext/zlib
RUN ["/usr/local/bin/ruby", "extconf.rb"]
RUN ["make"]
RUN ["make", "install"]
WORKDIR /root/installs/ruby-2.1.2/ext/openssl
ENV top_srcdir /root/installs/ruby-2.1.2
RUN ["make"]
RUN ["make", "install"]
WORKDIR /root
RUN ["rm", "-rf", "/root/installs/ruby-2.1.2"]
RUN ["rm", "/root/installs/ruby-2.1.2.tar.gz"]
RUN ["/usr/local/bin/gem", "install", "em-proxy"]
RUN ["/usr/local/bin/gem", "install", "ansi"]
RUN ["/usr/local/bin/gem", "install", "url"]

ADD proxy.rb /usr/local/bin/proxy.rb
RUN ["chmod", "777", "/usr/local/bin/proxy.rb"]
EXPOSE 3000
CMD ["/usr/local/bin/proxy.rb"]
