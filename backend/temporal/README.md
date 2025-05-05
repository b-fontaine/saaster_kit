# Temporal

Temporal est une plateforme open-source d’orchestration de workflows distribués, durable et hautement disponible, conçue pour exécuter de la logique métier asynchrone et de longue durée avec robustesse et résilience. Le SDK Go de Temporal offre aux développeurs Go un ensemble complet d’API pour définir des workflows, des activités, gérer les workers et interagir avec le service Temporal, tout en garantissant le déterminisme et la reprise sur échec. Cette documentation propose une vue d’ensemble structurée des concepts fondamentaux, des bonnes pratiques, de l’installation, du développement et du déploiement avec le SDK Go de Temporal.

## Introduction

Temporal est un moteur d’orchestration de workflows qui sépare la définition de la logique métier (Workflows et Activités) de leur exécution, assurant ainsi une traçabilité et une fiabilité accrues. Sa conception repose sur un modèle de Workflow-as-Code où chaque étape d’un processus peut être redémarrée ou rejouée de manière déterministe via un historique immuable d’événements.

## Concepts clés

### Workflows et Activités

Les **Workflows** sont des fonctions durables qui orchestrent l’exécution d’unités de travail (Activités) selon une logique séquentielle ou parallèle, tout en conservant un historique exécutable.
Les **Activités** sont des fonctions atomiques et externes au moteur Temporal, exécutées par des workers, et dont l’état est journalisé pour permettre la reprise selon les stratégies de retry définies.

### Workers, Task Queues et Namespaces

Un **Worker** est un processus Go qui enregistre des handlers de workflows et d’activités, et qui écoute des **Task Queues** pour recevoir des tâches à exécuter.
Les **Namespaces** isolent les workflows et fournissent des frontières de gestion des accès, de quota et de visibilité dans un cluster Temporal.

### Signaux, Requêtes et Timers

Les **Signaux** permettent d’envoyer des événements asynchrones à un workflow en cours d’exécution, modifiant dynamiquement son comportement.
Les **Requêtes** (Queries) offrent un accès en lecture seule à l’état courant d’un workflow sans en perturber l’exécution.
Les **Timers durables** font attendre un workflow pour une durée spécifiée, tout en gardant la consistance de l’historique.

### Versioning, Child Workflows et Continue-As-New

Le **versioning** assure la compatibilité ascendante des workflows en cours lors de mises à jour de code grâce à des patch APIs.
Les **Child Workflows** permettent de structurer un workflow parent en sous-processus réutilisables et isolés.
La fonctionnalité **Continue-As-New** évite la croissance infinie de l’historique en repartant une nouvelle exécution atomique sous le même Workflow ID.

### Sessions de Worker et Effets Secondaires

Les **Worker Sessions** offrent un contexte de travail transactionnel pour des activités nécessitant la conservation d’un état local entre plusieurs appels.
Les **Effets secondaires** (Side Effects) permettent d’exécuter du code non-déterministe à l’intérieur d’un workflow, tout en capturant et rejouant ses résultats de façon contrôlée.

## Installation et configuration

Pour installer le SDK Go, assurez-vous d’avoir Go 1.18+ et exécutez :

```bash
go get go.temporal.io/sdk@latest
```

Ce package fournit l’API client et les interfaces worker nécessaires à la définition et à l’exécution de workflows et activités.

## Développement avec le Go SDK

### Hello World

Dans `helloworld/workflow.go` :

```go
package helloworld

import "go.temporal.io/sdk/workflow"

func HelloWorkflow(ctx workflow.Context, name string) (string, error) {
    return "Hello, " + name + "!", nil
}
```

Dans `helloworld/activity.go` :

```go
package helloworld

func HelloActivity(name string) (string, error) {
    return "Hello, " + name + "!", nil
}
```

Dans `worker/main.go` :

```go
c, _ := client.Dial(client.Options{})
w := worker.New(c, "hello-task-queue", worker.Options{})
w.RegisterWorkflow(helloworld.HelloWorkflow)
w.RegisterActivity(helloworld.HelloActivity)
w.Run(worker.InterruptCh())
```

Cet exemple est extrait du dépôt officiel des samples Go de Temporal.

## Tests

Temporal fournit un framework de test permettant de simuler l’exécution synchrone de workflows et activités grâce à un environment in-memory, facilitant ainsi la validation et la vérification de vos définitions.

## Bonnes pratiques

* **Retries et Timeouts** : Définissez des politiques de retry sur les activités pour gérer les échecs transitoires et spécifiez des timeouts afin d’éviter les blocages indéfinis.
* **Observabilité** : Intégrez les métriques, le logging structuré et le tracing pour surveiller l’état et la performance des workflows.
