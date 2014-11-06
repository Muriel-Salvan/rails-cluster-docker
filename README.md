rails-cluster-docker
====================

Simple proof of concept set of docker containers which demonstrate how to create a
load balanced set of web applications running on your local machine using [https://www.docker.com](Docker).

To run 10 webservers and proxy them through the proxy:
```bash
$ fig build
$ fig scale server=10
$ fig up -d proxy

Visit http://(DOCKERIP):3000/hi in your browser a bunch of times, clearing the cache, and you
should see the host and ip change.

Inspired by a [https://github.com/Muriel-Salvan/rails-cluster-docker](very similar project)
