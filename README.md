# docker-vpn-in

Inbound OpenVPN server to allow connections to a private network.  

Tested this on Macs only. Use at your own peril.

## Terminology

|Term|Description|
|----|----|
|gateway| A device provided by an ISP that is accessible by its public ip from internet.|
|host| Computer where `container` is running. It has its own private ip address which is not visible from the internet.|
|container| Container is running on a `host` and it has internal ips that are not accessible from either the `host` or the internet. |

## Prerequisites
You will need [Docker](https://www.docker.com) to build and run this.  

## Building
To build: [bin/build.sh](bin/build.sh).

## Running

To run: [bin/run.sh](bin/run.sh).

## Port forwarding
By default `container` will come up and OpenVPN will be running on a port 31194 of the `host`.  
In order to be able to connect to the OpenVPN from the internet a port forwarding rule needs to be added to the `gateway`.  
`gateway:31194` --> `host:31194`.

If you need to change the port prefix, you can do it in [bin/setenv.sh](bin/setenv.sh).


## Connecting

Once container is up it will produce OpenVPN client configuration: `sharedfs/client-in.ovpn`.  

[Connection instructions](https://openvpn.net/vpn-server-resources/#documentation-subtab-connecting).

Please remember, client-in.ovpn changes on every build. 

## Troubleshooting

If you have openssh keys, the public key will be copied into the container and you will be able to use ssh to look around.
```
ssh -p 3322 root@localhost
```
