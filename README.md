#gcp-consul-image

Consul image for GCP, created to work with three server nodes.

Provision with:
```Console
./provisioner $NODE_NAME $DC_NAME $NODE_IP $NODE_IP2 $NODE_IP3 $ENCRYPT_KEY
```

$ENCRYPT_KEY is the key for consul gossip encryption.
