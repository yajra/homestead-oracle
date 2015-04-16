## Laravel Homestead with Oracle XE 11g
This project enables you to install Oracle 11g XE on Laravel's Homestead [base box](https://atlas.hashicorp.com/laravel/boxes/homestead), using
[Vagrant] and [Puppet].

## Acknowledgements
This project was created based on the information in the following projects:

* [Oracle XE 11g on Ubuntu 12.04 using Vagrant](https://github.com/hilverd/vagrant-ubuntu-oracle-xe)
* [Laravel Homestead](https://github.com/laravel/homestead)

## Requirements

* You need to have [Vagrant] installed.
* The host machine probably needs at least 4 GB of RAM (I have only tested 8 GB of RAM).
* As Oracle 11g XE is only available for 64-bit machines at the moment, the host machine needs to
  have a 64-bit architecture.
* You may need to [enable virtualization] manually.

## Installation

* Check out this project:

        git clone https://github.com/yajra/homestead-oracle.git

* Install [vbguest]:

        vagrant plugin install vagrant-vbguest

* Download [Oracle Database 11g Express Edition] for Linux x64. Place the file
  `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` in the directory `puppet/modules/oracle/files` of this
  project. (Alternatively, you could keep the zip file in some other location and make a hard link
  to it from `puppet/modules/oracle/files`.)

* Run `vagrant up` from the base directory of this project. The first time this will take a while -- up to 1 hour on
  my machine. Please note that building the VM involves downloading Laravel's Homestead [base box](https://atlas.hashicorp.com/laravel/boxes/homestead)

## Vagrant Provision
If you want to force re-provision the machine, I suggest running `vagrant provision --provision-with shell` for faster provisioning. This script will not include Oracle puppet scripts that takes more time to provision which is not necessary. Oracle puppet is required to only be executed once.

## Oracle Default Accounts
- sys / secret
- system / secret
- homestead / secret

## Connecting to Oracle

You should now be able to [connect](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html) to
the new database at `localhost:1521/XE` as `system` with password `secret`. For example, if you have `sqlplus` installed on the host machine you can do

    sqlplus system/secret@//localhost:1521/XE

To make sqlplus behave like other tools (history, arrow keys etc.) you can do this:

    rlwrap sqlplus system/secret@//localhost:1521/XE

You might need to add an entry to your `tnsnames.ora` file first:

    XE =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = XE)
        )
      )

## Troubleshooting

It is important to assign enough memory to the virtual machine, otherwise you will get an error

    ORA-00845: MEMORY_TARGET not supported on this system

during the configuration stage. In the `Vagrantfile` 512 MB is assigned. Lower values may also work,
as long as (I believe) 2 GB of virtual memory is available for Oracle, swap is included in this
calculation.

If you want to raise the limit of the number of concurrent connections, say to 200, then according
to [How many connections can Oracle Express Edition (XE) handle?] you should run

    ALTER SYSTEM SET processes=200 scope=spfile

and restart the database.

[Vagrant]: http://www.vagrantup.com/

[Puppet]: http://puppetlabs.com/

[Oracle Database 11g Express Edition]: http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

[Oracle Database 11g EE Documentation]: http://docs.oracle.com/cd/E17781_01/index.htm

[Installing Oracle 11g R2 Express Edition on Ubuntu 64-bit]: http://meandmyubuntulinux.blogspot.co.uk/2012/05/installing-oracle-11g-r2-express.html

[vagrant-oracle-xe]: https://github.com/codescape/vagrant-oracle-xe

[vbguest]: https://github.com/dotless-de/vagrant-vbguest

[asciicast]: https://asciinema.org/a/8438

[How many connections can Oracle Express Edition (XE) handle?]: http://stackoverflow.com/questions/906541/how-many-connections-can-oracle-express-edition-xe-handle

[enable virtualization]: http://www.sysprobs.com/disable-enable-virtualization-technology-bios
