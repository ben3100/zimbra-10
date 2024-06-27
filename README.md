# Zimbra 10 Installation Script

This repository contains a script to install and configure Zimbra Collaboration Suite 10 on an Ubuntu 20.04 server. The script prompts the administrator for input during the installation process to customize the configuration.

## Features

- Prompts for the fully qualified domain name (FQDN) and timezone.
- Updates the system and installs required dependencies.
- Configures hostname and DNS resolution.
- Installs and configures `dnsmasq` for local DNS resolution.
- Downloads and installs Zimbra.
- Configures the firewall to allow necessary ports.
- Restarts Zimbra services and verifies the installation.

## Prerequisites

- Ubuntu 20.04 server with root or sudo access.
- Internet connection to download Zimbra and dependencies.

## Usage

1. **Clone the repository**:

    ```sh
    git clone https://github.com/ben3100/zimbra-10.git
    cd zimbra-10
    ```

2. **Make the script executable**:

    ```sh
    chmod +x install_zimbra_interactive.sh
    ```

3. **Run the script with root privileges**:

    ```sh
    sudo ./install_zimbra_interactive.sh
    ```

4. **Follow the prompts**:

    The script will ask you to enter the fully qualified domain name (FQDN) for your Zimbra server and your timezone. Make sure to enter these values correctly.

## Script Overview

The `install_zimbra_interactive.sh` script performs the following actions:

1. **System Update**: Updates package lists and upgrades installed packages.
2. **Set Hostname**: Prompts for the FQDN and sets the hostname.
3. **Configure DNS Resolution**: Updates `/etc/hosts` and `/etc/resolv.conf` to use Google's DNS servers.
4. **Disable systemd-resolved**: Stops and disables the systemd-resolved service.
5. **Install Dependencies**: Installs required packages including `dnsmasq-base`.
6. **Configure dnsmasq**: Configures `dnsmasq` for local DNS resolution.
7. **Set Timezone**: Prompts for the timezone and sets it.
8. **Download and Extract Zimbra**: Downloads the Zimbra package and extracts it.
9. **Install Zimbra**: Runs the Zimbra installation script with platform override.
10. **Run Zimbra Setup**: Finalizes the Zimbra setup.
11. **Restart Zimbra Services**: Restarts Zimbra services to apply changes.
12. **Configure Firewall**: Opens necessary ports for Zimbra services.

# Zimbra 10 Deployment Scripts

## Description

Ce dépôt contient des scripts pour installer, déployer et configurer Zimbra 10 sur Ubuntu 20.04, à la fois sur un serveur unique (monoserveur) et sur une infrastructure Google Cloud Platform (GCP). Ces scripts sont conçus pour simplifier et automatiser le processus d'installation et de configuration, en garantissant une configuration optimale et sécurisée.

## Fonctionnalités

- **Installation Automatisée** : Installez et configurez Zimbra 10 sur un serveur unique.
- **Déploiement sur GCP** : Déployez Zimbra 10 sur Google Cloud Platform avec une configuration personnalisée.
- **Sécurité** : Intègre des règles de pare-feu et des configurations de sécurité.

## Contenu du Dépôt

- `install_zimbra_monoserver.sh` : Script pour installer et configurer Zimbra sur un serveur unique.
- `deploy_zimbra_gcp_interactive.sh` : Script interactif pour déployer et configurer Zimbra sur GCP.

## Prérequis

- Compte Google Cloud Platform avec un projet configuré.
- Accès administrateur au serveur Ubuntu 20.04.
- `gcloud` CLI installé et configuré.

## Instructions

### Installation sur un Serveur Unique

1. Clonez ce dépôt sur votre serveur :
   ```bash
   git clone https://github.com/ben3100/zimbra-10.git
   cd zimbra-10
Exécutez le script d'installation :

bash
Copier le code
chmod +x install_zimbra_monoserver.sh
./install_zimbra_monoserver.sh
Suivez les instructions à l'écran pour terminer l'installation et la configuration.

Déploiement sur Google Cloud Platform (GCP)
Clonez ce dépôt sur votre machine locale :

bash
Copier le code
git clone https://github.com/ben3100/zimbra-10.git
cd zimbra-10
Exécutez le script de déploiement interactif :

bash
Copier le code
chmod +x deploy_zimbra_gcp_interactive.sh
./deploy_zimbra_gcp_interactive.sh
Suivez les instructions interactives pour configurer votre déploiement (ID de projet, région, zone, etc.).

Contribuer
Les contributions sont les bienvenues ! Si vous avez des idées pour améliorer ces scripts, n'hésitez pas à créer une pull request ou à ouvrir une issue.

Auteurs
Ben Belaouedj
Licence
Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.
13. **Completion Message**: Displays a message indicating that the installation is complete and provides the URL for the Zimbra admin interface.

## Accessing Zimbra

After the installation is complete, you can access the Zimbra admin interface via the following URL:

