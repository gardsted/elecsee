# elecsee

You need to apt install lxd to play with these scripts

## lxc-based

The program **lxc-based** creates lxc-containers (lxd), puts them in hosts file and adds public key.

To change LINUX from ubuntu:18.04 into something else, look at available images like this: 

    lxc image list images:


## lxc-based models

Running 

    lxc-based solr-model

Will create a model-image to use when creating solr-containers (it is preconfigured with java, and solr has been downloaded into the root folder)

Running 

    lxc-based solr-1

Will create a solr-node by copying the model-image instead of downloading all again.

## models

Currently there are these models supplied (in the scripts directory):

* msf - creates a model-image for the metasploit framework
* solr - creates a model-image for solr/searching indexing (w. java+solr)


