# Zimbra 10 Deployment Scripts

## Description

Ce dépôt contient des scripts pour installer, déployer et configurer Zimbra Collaboration Suite 10 sur Ubuntu 20.04, à la fois sur un serveur unique (monoserveur) et sur une infrastructure Google Cloud Platform (GCP). Ces scripts sont conçus pour simplifier et automatiser le processus d'installation et de configuration, en garantissant une configuration optimale et sécurisée.

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
- Connexion Internet pour télécharger Zimbra et les dépendances.

## Usage

### Installation sur un Serveur Unique

1. **Clonez ce dépôt sur votre serveur** :

    ```bash
    git clone https://github.com/ben3100/zimbra-10.git
    cd zimbra-10
    ```

2. **Rendez le script exécutable** :

    ```bash
    chmod +x install_zimbra_monoserver.sh
    ```

3. **Exécutez le script avec les privilèges root** :

    ```bash
    sudo ./install_zimbra_monoserver.sh
    ```

4. **Suivez les instructions à l'écran** :

    Le script vous demandera d'entrer le nom de domaine complet (FQDN) de votre serveur Zimbra et votre fuseau horaire. Assurez-vous de saisir ces valeurs correctement.

### Déploiement sur Google Cloud Platform (GCP)

1. **Clonez ce dépôt sur votre machine locale** :

    ```bash
    git clone https://github.com/ben3100/zimbra-10.git
    cd zimbra-10
    ```

2. **Rendez le script exécutable** :

    ```bash
    chmod +x deploy_zimbra_gcp_interactive.sh
    ```

3. **Exécutez le script de déploiement interactif** :

    ```bash
    ./deploy_zimbra_gcp_interactive.sh
    ```

4. **Suivez les instructions interactives** :

    Le script vous guidera pour configurer votre déploiement (ID de projet, région, zone, etc.).

## Script Overview

### `install_zimbra_monoserver.sh`

Le script `install_zimbra_monoserver.sh` effectue les actions suivantes :

1. **Mise à jour du système** : Met à jour les listes de paquets et met à niveau les paquets installés.
2. **Configuration du nom d'hôte** : Demande le FQDN et le configure.
3. **Configuration de la résolution DNS** : Met à jour `/etc/hosts` et `/etc/resolv.conf` pour utiliser les serveurs DNS de Google.
4. **Désactivation de systemd-resolved** : Arrête et désactive le service systemd-resolved.
5. **Installation des dépendances** : Installe les paquets nécessaires, y compris `dnsmasq-base`.
6. **Configuration de dnsmasq** : Configure `dnsmasq` pour la résolution DNS locale.
7. **Configuration du fuseau horaire** : Demande le fuseau horaire et le configure.
8. **Téléchargement et extraction de Zimbra** : Télécharge et extrait le paquet Zimbra.
9. **Installation de Zimbra** : Exécute le script d'installation de Zimbra avec le remplacement de la plateforme.
10. **Configuration finale de Zimbra** : Finalise la configuration de Zimbra.
11. **Redémarrage des services Zimbra** : Redémarre les services Zimbra pour appliquer les modifications.
12. **Configuration du pare-feu** : Ouvre les ports nécessaires pour les services Zimbra.
13. **Message de fin** : Affiche un message indiquant que l'installation est terminée et fournit l'URL de l'interface d'administration de Zimbra.

## Contribuer

Les contributions sont les bienvenues ! Si vous avez des idées pour améliorer ces scripts, n'hésitez pas à créer une pull request ou à ouvrir une issue.

## Auteurs

- [Ben Belaouedj](https://www.linkedin.com/in/benbelaouedj)

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Accéder à Zimbra

Après l'installation, vous pouvez accéder à l'interface d'administration de Zimbra via l'URL suivante :

