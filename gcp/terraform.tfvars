// global variables
name           = "pen"             // prefix for resource names
project_id     = "coder-pentest-0" // your GCP project ID
region         = "us-central1"     // region in which your cluster will be deployed
zone           = "us-central1-c"
namespace      = "coder"             // k8s namespace in which Coder will be installed
coder_version  = "1.21.1"            // coder version to be installed - if null, latest version will be used
machine_type   = "e2-standard-8"     // node size to be used by k8s. see additional machine types here: https://cloud.google.com/compute/docs/machine-types
image_type     = "UBUNTU_CONTAINERD" // node image. we recommend any image with a Kernel version of 5.x, to be compatible with CVMs: https://coder.com/docs/coder/v1.20/workspaces/cvms
disk_size_gb   = 100                 // we recommend a disk of at least 100 GBs, to avoid the potential for pod evictions
min_node_count = 1                   // min amount of nodes provisioned by auto-scaling
max_node_count = 4                   // max amount of nodes provisioned by auto-scaling