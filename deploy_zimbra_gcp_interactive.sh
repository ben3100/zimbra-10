#!/bin/bash

# Script pour déployer et configurer Zimbra sur Google Cloud Platform avec interaction utilisateur

echo "Déploiement de Zimbra sur Google Cloud Platform"

# Demande à l'utilisateur d'entrer l'ID du projet GCP
read -p "Entrez l'ID de votre projet GCP : " PROJECT_ID

# Configure le projet
gcloud config set project $PROJECT_ID

# Demande à l'utilisateur de choisir la région et la zone
read -p "Entrez la région (exemple : europe-west1) : " REGION
read -p "Entrez la zone (exemple : europe-west1-b) : " ZONE

# Demande à l'utilisateur d'entrer le nom du VPC
read -p "Entrez le nom du VPC : " VPC_NAME

# Crée le VPC
gcloud compute networks create $VPC_NAME --subnet-mode=custom

# Demande à l'utilisateur d'entrer le nom du sous-réseau et la plage IP
read -p "Entrez le nom du sous-réseau : " SUBNET_NAME
read -p "Entrez la plage IP du sous-réseau (exemple : 10.0.0.0/24) : " SUBNET_RANGE

# Crée le sous-réseau
gcloud compute networks subnets create $SUBNET_NAME --network=$VPC_NAME --region=$REGION --range=$SUBNET_RANGE

# Configure les règles de pare-feu
gcloud compute firewall-rules create zimbra-allow-internal --network $VPC_NAME --allow tcp,udp,icmp --source-ranges $SUBNET_RANGE
gcloud compute firewall-rules create zimbra-allow-external --network $VPC_NAME --allow tcp:22,tcp:25,tcp:80,tcp:110,tcp:143,tcp:443,tcp:465,tcp:587,tcp:993,tcp:995,tcp:7071 --source-ranges 0.0.0.0/0

# Demande à l'utilisateur d'entrer les détails de l'instance
read -p "Entrez le nom de l'instance : " INSTANCE_NAME
read -p "Entrez le type de machine (exemple : n1-standard-4) : " MACHINE_TYPE
read -p "Entrez la taille du disque (exemple : 100GB) : " DISK_SIZE

# Demande à l'utilisateur d'entrer l'URL du script de démarrage
read -p "Entrez l'URL du script de démarrage : " STARTUP_SCRIPT_URL

# Crée l'instance Zimbra
gcloud compute instances create $INSTANCE_NAME \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --subnet=$SUBNET_NAME \
  --image-family=ubuntu-2004-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=$DISK_SIZE \
  --metadata=startup-script-url=$STARTUP_SCRIPT_URL

echo "Déploiement de Zimbra sur GCP terminé avec succès !"
