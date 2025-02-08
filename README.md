# Family Tree

<br>

<img
src="https://lh3.googleusercontent.com/d/1H04KVAA3ohH_dLXIrC0bXuJXDn3VutKc"
alt = "Dinobox logo" width="100"/>

Self-hosting a family tree website, made with [MacFamilyTree][def], in a
docker container, using nginx. While these instructions apply to
[MacFamilyTree][def], any genealogy software that can publish a complete
website (html) of a family tree will work.

## Steps

### Clone the repo

Start by cloning this repo onto the target server. Then run:

```text
cd familytree
make setup
```

### Export the website

Export the website of a family tree created with [MacFamilyTree][def] to
a folder. Compress (tar) the folder containing the site and copy the
tarball to the target server. Un-tar it on the server, and copy all the
files as follows:

```text
cp -R <folder containing files>/* ~/familytree/data/tree
```

### Generate a username and password

From your home directory, generate a username and password (let's say
user "zeke"). First change to your home directory:

```text
cd
```

Now generate a password:

```text
echo -n 'zeke:' >> htpasswd
openssl passwd -apr1 >> htpasswd
```

You'll be presented with an interactive session to enter and confirm a
password. You can use this process to create as many usernames /
passwords as you like.

### Move passwords into position

Move the password file into position as follows:

```text
mv htpasswd ~/familytree/data
```

### Make the docker image

```text
cd ~/familytree
make image
```

### Start the container

Spin-up a docker container using a copy of the `compose-example.yml`
file in this repo. _See the notes in the `compose-example.yml` file for
more details._

## Updating Family Data

When you update your family tree and you want to publish an updated
website, start by purging the old data using:

```text
cd ~/familytree
make reset
```

then:

* Export the website
* Make the docker image
* Start the container

## Note

If you're creating tarballs on macOS and un-taring them on Linux, you
may run into an issue with extended attributes. [Here's a description of
the issue][def2], with recommended fixes using homebrew.

[def]: https://www.syniumsoftware.com/macfamilytree
[def2]: https://superuser.com/questions/318809/linux-os-x-tar-incompatibility-tarballs-created-on-os-x-give-errors-when-unt
