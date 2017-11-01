Bad Dockerfile
==============

Overview
--------

Reference Dockerfile containing software with known vulnerabilities.

Includes vulnerable binaries (bash shellshock, wget directory traversal) with
CVE entries for testing Docker image scanning solutions.

For full details see: http://www.stindustries.net/docker/bad-dockerfile/

Created by Adrian Portelli.

Image available here: https://hub.docker.com/r/imiell/bad-dockerfile

But note that it's insecure!


How to
======

Pull an already-built image
---------------------------

    docker pull imiell/bad-dockerfile


Build locally
-------------

If your build host can reach the Internet:

    docker build -t imiell/bad-dockerfile ./


If your build host needs proxy settings to reach the Internet:

    # Replace ... with exotic curl options for your build environment.
    docker build -t imiell/bad-dockerfile --build-arg CURL_OPTIONS="..." ./
