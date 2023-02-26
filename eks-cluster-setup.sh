
#!/bin/bash
#Variables
CLUSTER_NAME=projectname-eks-cluster3
REGION=us-east-1
NODE_NAME=linux-nodes1
KEY_NAME=Newkeypair


#Set AWS credentials before script execution

aws sts get-caller-identity >> /dev/null

if [ $? -eq 0 ]
then 

  echo "Credentials tested,proceeding with the cluster creation."

  #Creation of EKS cluster
  eksctl create cluster \
  --name $CLUSTER_NAME \
  --version 1.22 \
  --region $REGION \
  --nodegroup-name $NODE_NAME \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 4 \
  --node-type t3.medium \
  --node-volume-size 8 \
  --ssh-access \
  --ssh-public-key $KEY_NAME \
  --managed

  if [ $? -eq 0 ]
  then 
     echo "Cluser Setup Completed with eksctl command."
  else
     echo "Cluster Setup Failed while running eksctl command."
  fi
else
    echo "Please run aws configure & set right credentials"
    echo "Cluster Setup faild"
fi
