<!-- VARIABLES
SERVICE
PROJECT
REPOSITORY
ORGANIZATION
-->

# PROJECT Api

## À propos

Ce dépot est responsable de la partie applicative serveur du projet PROJECT.

## Table des matières

- 🪧 [À propos](#à-propos)
- 📦 [Prérequis](#prérequis)
- 🚀 [Installation](#installation)
- 🛠️ [Utilisation](#utilisation)
- 🤝 [Contribution](#contribution)
- 🏗️ [Construit avec](#construit-avec)
- 📝 [Licence](#licence)

## Prérequis

- [Git](https://git-scm.com/) : Système de contrôle de versions distribué d'un ensemble de fichiers
- [Node](https://nodejs.org/) : Environnement d'exécution pour Javascript

> Node peut être installé via [nvm](https://github.com/nvm-sh/nvm) qui permet d'obtenir et d'utiliser rapidement différentes versions de Node via la ligne de commande.

## Installation

### Mise en place des sources

Cloner le projet

## Utilisation

Ces commandes servent dans un contexte de développement de l'application et doivent être exécutées depuis la racine de l'espace de travail.

### Mise en place des prérequis

```bash
npm install
```

#### Lancer le serveur api en local

```bash
npm run build
npm run start-local
```

### Développement local

Les commandes communes de développement se trouvent dans le champ `scripts` du package.json
L'api se repose sur un service de base de données [PostgreSQL](https://www.postgresql.org/) qui peut être montée en local sur docker.

### Contribution

Le projet n'est actuellement pas ouvert à la contribution.

### Outils
#### CI/CD

- [Github Actions](https://docs.github.com/en/actions) est l'outil d'intégration et de déploiement continu intégré à GitHub
    - L'historique des déploiements est disponible [sous l'onglet Actions](https://github.com/ORGANIZATION/REPOSITORY/actions/)
  
- Secrets du dépôt :
    - `AWS_ACCESS_KEY_ID` : L'identifiant de la clef du compte programmatique qui permet de pousser l'image du conteneur sur ECR
      - Provisionné par le organization.deployer du compte AWS parent de l'organization
    - `AWS_SECRET_ACCESS_KEY` : La clef secrete du compte programmatique qui permet de pousser l'image du conteneur sur ECR
        - Provisionné par le organization.deployer du compte AWS parent de l'organization

- [AWS](https://aws.amazon.com/) est la plateforme de services Cloud proposée par Amazon.
    - Utilisateur : `PROJECT.SERVICE.ci`
    - Groupe : `SERVICE.deployer`
  
- [ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html) Amazon Elastic Container Registry (Amazon ECR) est un service de registre d'images de conteneur géré par AWS.


## Licence

Voir le fichier [LICENSE.md](./LICENSE.md) du dépôt.
