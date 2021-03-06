[![Build Status](https://travis-ci.org/beyondcoin-project/beyondcoin-seeder.svg?branch=master)](https://travis-ci.org/beyondcoin-project/beyondcoin-seeder)

Beyondcoin-Seeder
=================

The Beyondcoin-Seeder is a crawler for the Beyondcoin network, which exposes a list
of reliable nodes via a built-in DNS server.

Features:
* Regularly revisits known nodes to check their availability.
* Bans nodes after enough failures, or bad behaviour.
* Accepts nodes down to v0.15.1 to request new IP addresses from,
  but only reports good post-v0.15.1 nodes.
* Keeps statistics over (exponential) windows of 2 hours, 8 hours,
  1 day and 1 week, to base decisions on.
* Very low memory (a few tens of megabytes) and cpu requirements.
* Crawlers run in parallel (by default 96 threads simultaneously).

REQUIREMENTS
------------

> $ sudo apt-get install build-essential libboost-all-dev libssl-dev

USAGE
-----

Assuming you want to run a dns seed on dnsseed.example.com, you will
need an authorative NS record in example.com's domain record, pointing
to for example vps.example.com:

> $ dig -t NS dnsseed.example.com

#### ANSWER SECTION

> dnsseed.example.com.   86400    IN      NS     vps.example.com.

On the system vps.example.com, you can now run dnsseed:

> ./dnsseed -h dnsseed.example.com -n vps.example.com

If you want the DNS server to report SOA records, please provide an
e-mail address (with the @ part replaced by .) using -m.

COMPILING
---------
Compiling will require boost and ssl.  On debian systems, these are provided
by `libboost-dev` and `libssl-dev` respectively.

> $ make

This will produce the `dnsseed` binary.

RUNNING AS NON-ROOT
-------------------

Typically, you'll need root privileges to listen to port 53 (name service).

One solution is using an iptables rule (Linux only) to redirect it to
a non-privileged port:

> $ iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-port 5353

If properly configured, this will allow you to run dnsseed in userspace, using
the -p 5353 option.
