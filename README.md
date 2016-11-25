My Hadoop Demo
==============

These scripts make it a little easier to set up HDP.

Pre-requisites
--------------
* 64-bit Ubuntu (12.04 or 14.04) or REHL / CentOS 6/7
* PDSH installed on your bastion server (where you execute this script)
* Password-less SSH login from your bastion to all nodes


Demostrations
-------------

# Set up bastion server
All the demostrations are operated on the bastion server. An t2.micro EC2 instance is fine.

# Demo Command Usages

    Usage: ./hdemo [-c command] [-s subcommand] [-e command]

    -c command [-s subcommand]: run command on specific nodes
    Supported commands
        check-reachability: check reachability for all nodes
        distribute-hdemo: distribute hdemo to all nodes
        prepare: prepare for hadoop setup, runs on all nodes
        setup-ambari-server: setup ambari server, run on ambari server
        setup-ambari-agents: setup ambari agent, run on all nodes

        ambari-server: start / stop /status ambari server
        ambari-agents: start / stop /status ambari agent


        -e command: run adhoc command on all nodes


# Step by Step Demostration Manual
All the following operations are done on the bastion server.

    # Edit environment variables in conf/env.sh
    $ vi conf/env.sh

    # Prepare environment
    $ ./hdemo -c check-reachability
    $ ./hdemo -c prepare

    # Set up Ambari
    $ ./hdemo -c setup-ambari-server
    $ ./hdemo -c setup-ambari-agents

    # Start Ambari
    $ ./hdemo -c ambari-server -s start
    $ ./hdemo -c ambari-agents -s start

Enjoy Hadoop!
