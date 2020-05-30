#!/bin/bash
nohup java -jar /home/vagrant/deployment/*.war > /home/vagrant/deployment/log.txt 2>&1 &
echo $! > /home/vagrant/deployment/pid.file
