Splunk Demo
===========

Movie and Snack Sales
---------------------

The purpose of this docker image is to install the base Splunk image with the evaluation license, then setup a demonstration environment using data generated with a current timestamp.

This container is provided as a quick demonstration starting point for real time data.  Data is generated in real time for approximately 20-25 minutes once the container image is started and Splunk installed.  The base image for this container is from Splunk (splunk/splunk) with minor modifications to copy the /gendata directory and overlay the 'entrypoint.sh' script with two additional commands to add a monitor for /gendata/*.logs and start the /gendata/gentickets.sh script.

Requirements
--------------------

[Docker for Windows](https://docs.docker.com/docker-for-windows/install/) **or** [Docker for Linux](https://docs.docker.com/install/)

How to
----------

Actions | Command
-----------|-----------------
**To pull the latest copy of the container** | docker pull niceine/splunkdemo
**To build the container** | docker build --tag=niceine/splunkdemo:011 --tag=niceine/splunkdemo:latest . |
**To start the container:  (Quick start)** | docker run -d -p 8000:8000 --name splunkdemo niceine/splunkdemo
**To stop the container** | docker stop splunkdemo
**To remove the container** | docker rm splunkdemo
**To follow the logs while the container starts** | docker logs -f splunkdemo
**To load Splunk in your web browser** | http://[machinename]:8000 (machine name is the name of your host machine)
**To add the monitor for the generating sales** | /opt/splunk/bin/splunk add monitor -source /gendata/sales.log -auth admin:Sp1unk%%
**To start the generating of data** | docker exec -d -u splunk splunkdemo "/gendata/gentickets.sh gendata &"
**To load more data** | docker exec -d -u splunk splunkdemo "/gendata/gensales -d [delay in seconds per customer]"

user: **admin**, password: **Sp1unk%%**

_Note:_ 

_Please wait 60-90 seconds AFTER starting the container to allow the process to complete the install and begin data generation before attempting to search the data._



