# BACnet Tools in Docker

This is a simple packaging of the [BACnet Protocol Stack](https://sourceforge.net/projects/bacnet) into a single docker image. Once there it's simple to simulate a network of BACnet/IP clients and servers of various types, each in their own container, specified by a simple docker-compose file. BACnet/ethernet might also be possible, but I haven't tried yet.

It's instructive observe the traffic between containers with Wireshark or tcpdump.

## Usage
First, build the BACnet container.

```
$ docker build -t bacnet .
```

Next, stand up several servers by editing docker-compose.yml for desired number of servers, clients, and device IDs, then:

```
$ docker-compose up -d
```

The "-d" runs everything in the background.  You can then observe logs from all of them like this:

```
$ docker-compose logs
Attaching to bacnet_whois_1, bacnet_server1_1, bacnet_server2_1, bacnet_server3_1
whois_1    | Received I-Am Request from 200002, MAC = 172.17.0.3 BAC0
whois_1    | Received I-Am Request from 200001, MAC = 172.17.0.4 BAC0
whois_1    | Received I-Am Request from 200003, MAC = 172.17.0.2 BAC0
whois_1    | ;Device   MAC (hex)            SNET  SADR (hex)           APDU
whois_1    | ;-------- -------------------- ----- -------------------- ----
whois_1    |   200002  AC:11:00:03:BA:C0    0     00                   1476 
whois_1    |   200001  AC:11:00:04:BA:C0    0     00                   1476 
whois_1    |   200003  AC:11:00:02:BA:C0    0     00                   1476 
whois_1    | ;
whois_1    | ; Total Devices: 3
```

You can also issue commands as needed from a new, transient container:

```
$ docker run -it bacnet bacwi
$ docker run -it bacnet bacepics -v 200002
etc
```
See the [BACnet stack bin documentation](https://sourceforge.net/p/bacnet/code/HEAD/tree/branches/releases/bacnet-stack-0-8-0/bin/readme.txt) for ideas.

## Packet Capture
The example `docker-compose.yml` uses bridge-mode networking, which means the `docker0` network interface (on Linux hosts, anyway) is usually carrying all the ethernet traffic. The tcpdump command looks like this; the wireshark one is similar.

```
$ sudo tcpdump -i docker0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on docker0, link-type EN10MB (Ethernet), capture size 262144 bytes
13:17:59.066397 IP6 foo > ff02::16: HBH ICMP6, multicast listener report v2, 2 group record(s), length 48
13:17:59.320945 IP 172.17.0.2.47808 > 172.17.255.255.47808: UDP, length 25
13:17:59.862393 IP6 foo > ff02::16: HBH ICMP6, multicast listener report v2, 2 group record(s), length 48
...
```

## Comms Welcome
Feel free to submit issues or pull requests.
