# Family Tree

<br>

<img
src="https://lh3.googleusercontent.com/d/1H04KVAA3ohH_dLXIrC0bXuJXDn3VutKc"
alt = "Dinobox logo" width="100"/>

Self-hosting a Family Tree made with MacFamilyTree

## Setup

1. Start by cloning this repo onto the target server. Then run:

    ```shell
    cd familytree
    make setup
    ```

2. Export the site (html) from MacFamilyTree. Compress (tar) it and copy
   everything to the target server. Unpack it, and copy all the files as
   follows:

    ```zsh
    cp -R <location of files>/* ~/familytree/data/tree
    ```

3. Generate a username and password (let's say user "zeke"):

    ```shell
    echo -n 'zeke:' >> htpasswd
    openssl passwd -apr1 >> htpasswd
    ```

    You'll be presented with an interactive session to enter and confirm
    a password. You can use this process to create as many
    usernames/passwords as you like.

4. Move the password file as follows:

    ```shell
    mv htpasswd ~/familytree/data
    ```

5. Make the image:

    ```shell
    cd ~/familytree
    make image
    ```

6. Spin-up a docker container using the `compose.yml` file in the
   toolkit.

## Updating family data

When you update your family tree, start by purging the old data using:

```shell
cd ~/familytree
make reset
```

Then start with step 5 above.
