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

#### Docker one-liner

Pour monter une base vierge afin de tester

```shell
docker run -d \
  --name postgres \
  --shm-size=512m \
  -p 5432:5432 \
  -e POSTGRES_DB=database \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -v "$(pwd)/docker-data/postgresql:/var/lib/postgresql/data" \
  postgres:14.6
```

#### Tester

```shell
❯ curl  http://0.0.0.0:3000                                                                                                                                                                                                                                                1.64   14,6G   0,B   100% 
OK
```

Sans base de données
```shell
❯ curl  http://0.0.0.0:3000/database-status                                                                                                                                                                                                                                1.60   14,6G   0,B   100% 
{"statusCode":500,"code":"ECONNREFUSED","error":"Internal Server Error","message":"connect ECONNREFUSED 127.0.0.1:5432"}%
```

Avec base de données vierge
```shell
❯ curl  http://0.0.0.0:3000/database-status                                                                                                                                                                                                                                1.18   14,8G   0,B   100% 
{"databaseSize":{"pg_size_pretty":"8553 kB"},"numberOfConnexions":{"count":"1"},"numberOfActiveConnexions":{"count":"1"},"listOfAllPublicTables":"[]"}%
```

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
