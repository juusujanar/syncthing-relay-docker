:warning: Syncthing now offers an official Docker image for their Relay server: https://hub.docker.com/r/syncthing/relaysrv

**This repository is archived and will not get any further updates.**

---

# Syncthing Relay server in Docker

This repository offers a Syncthing Relay server in a Docker image format. The relay servers are used in situations, where clients can not connect directly to each other, for example due to NAT or firewalls.

The Docker image is available for AMD64, ARMv6, ARMv7 and ARMv8.

More information about relay servers: https://docs.syncthing.net/users/relaying.html

This repository uses code from upstream Syncthing repository: https://github.com/syncthing/syncthing

## How to run

Use the following Docker command to run the Syncthing Relay server:

    docker run --restart=always -p 22067:22067 -p 22070:22070 ghcr.io/juusujanar/syncthing-relay-docker:v1.23.4

Port 22067 is used for the relay protocol, and port 22070 is used for metrics collection.
If you want to use non-default port, for example 443 instead of 22067 (some clients' firewalls might block non-standard ports), you can use the following command:

    docker run --restart=always -p 443:22067 -p 22070:22070 ghcr.io/juusujanar/syncthing-relay-docker:v1.23.4

You can go to http://relays.syncthing.net/ to check if your relay is listed.

### Private relays

Alternatively, if you want to run your relay privately, use the following command:

    docker run --restart=always -p 22067:22067 -p 22070:22070 ghcr.io/juusujanar/syncthing-relay-docker:v1.23.4 -pools=""

This will not list your relay on the public relay pool, but you can still use it for your own devices.

However it is recommended to to mount a volume to ensure the server uses the same key after reboot.

    docker run --restart=always -p 22067:22067 -p 22070:22070 -v syncthing-relay:/opt/strelaysrv ghcr.io/juusujanar/syncthing-relay-docker:v1.23.4 -pools="" -keys=/relay.key
