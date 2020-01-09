# gcp-consul-image

Consul image for GCP usisng Ubuntu 16.04, created to work with three server nodes.

Provision with:
```Console
./provisioner $NODE_NAME $DC_NAME $NODE_IP $NODE_IP2 $NODE_IP3 $ENCRYPT_KEY
```

$ENCRYPT_KEY is the key for consul gossip encryption.
$PATH_TO_KEY is the same ssh key used on 2.javier-claivaux/gcp-consul-vault-cluster

To create  image run:
```Console
$ packer build consul-gcp.json 

```

