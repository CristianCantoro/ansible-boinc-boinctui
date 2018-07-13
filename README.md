ansible-boinc-boinctui
----------------------

This is an ansible playbook to setup a new machine with Docker and deploy a
container with a [Boinc][boinc] client and [boinctui][boinctui].

Most of the task are imported from my other project [`ansible-basic-setup-with-docker-and-shadowsocks`][ansible-basic-setup-with-docker-and-shadowsocks].

## Workflow

1. Update root password and add SSH key (role: `add-user`).

2. Enable locales (role: `locales`).

3. Set new hostname (role: `set-hostname`).

4. Resize boot partition (role: `resize-boot-partition`).

5. Add swap (role: `swap`).

6. Upgrade system (role: `upgrade-release`).

7. Install basic packages (role: `install-basics`).

8. Install Docker (role: `ansible-docker`).

9. Add shadowsocks user (role: `add-user`).

10. Secure SSH (role: `secure-ssh`).

11. Enable UFW (role: `set-ufw`).

12. Deploy docker containers for boinc client and boinctui (role: `deploy-docker-boinc-boinctui`).


## Roles:

Fhe roles `add-user`, `ansible-docker`, `ansible-ssh-hardening`,
`install-basics`, `locales`, `reboot`, `resize-boot-partition`,
`root-password-change`, `secure-ssh`, `set-hostname`, `set-ufw`, `ssh-filter`,
`swap`, `upgrade-release` are documented in [`ansible-basic-setup-with-docker-and-shadowsocks`][ansible-basic-setup-with-docker-and-shadowsocks].

This repo adds a new role:
* `deploy-docker-boinc-boinctui`:
  ensure [docker compose](https://docs.docker.com/compose/) is installed and:
    - deploy a container with the official [boinc client docker image][docker-boinc-client];
    - pull the image for [boinctui][docker-boinctui];
    - install a script to `/usr/local/bin/` to `boinctui` from a container

---
[boinc]: https://boinc.berkeley.edu/
[boinctui]: https://github.com/suleman1971/boinctui
[ansible-basic-setup-with-docker-and-shadowsocks]: https://github.com/CristianCantoro/ansible-basic-setup-with-docker-and-shadowsocks
[docker-boinc-client]: https://hub.docker.com/r/boinc/client/
[docker-boinctui]: https://hub.docker.com/r/pataquets/boinctui/