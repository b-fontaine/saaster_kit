# Starter Kit SaaS B2B

Ce **starter kit** fournit une base robuste, modulable et sécurisée pour développer un SaaS B2B full-stack, prêt à l’emploi en local. Il intègre :

- **Frontend** : Flutter (Web / Mobile / Desktop)  
- **API Gateway & WAF** : Traefik + ModSecurity  
- **IAM** : Keycloak (OAuth2 / OIDC)  
- **Orchestration** : Temporal (workflows _event-driven_)  
- **Microservices** : Go, chacun avec sa propre base PostgreSQL  
- **Service mesh** : Dapr, Linkerd (mTLS, load-balancing, retries, circuit-breaker, health checks)  
- **Observabilité** : Prometheus, Grafana (métriques) et ElasticSearch (logs)  

---

## Installation et démarrage

```bash
docker compose -p SaaSter up -d
```

> **Note** : en environnement de production, remplacez les certificats ACME de développement par des certificats TLS fiables, et migrez vers Kubernetes à l’aide de vos manifests ou Helm charts.

---

## Description de l’architecture

```mermaid
---
config:
  theme: neo
  layout: elk
---
flowchart LR
   subgraph Flutter["Flutter"]
      A1["Web"]
      A2["Mobile"]
      A3["Desktop"]
   end
   subgraph IAM["IAM"]
      C["Keycloak (OAuth2/OIDC)"]
   end
   subgraph Gateway["Gateway"]
      B["Traefik + ModSecurity (WAF)"]
   end
   subgraph Orchestration["Orchestration"]
      direction TB
      D["Temporal (Workflow Engine)"]
      D1["Temporal (Admin Tools)"]
      D2["Temporal (Web UI)"]
      D3[("Temporal (Database)")]
   end
   subgraph Mesh
      M[Linkerd Sidecars]
   end
   subgraph Micro-Services
      subgraph s1["Auth-Service"]
         Service1["Auth-Service (Go)"]
         DB-Service1[("auth_db")]
         Dapr1["Dapr Sidecar"]
      end
      subgraph s2["User-Service"]
         Service2["User-Service (Go)"]
         DB-Service2[("user_db")]
         Dapr2["Dapr Sidecar"]
      end
   end
   subgraph s3["Observabilité"]
      G["Grafana"]
      P["Prometheus"]
      L["ElasticSearch"]
   end
   Orchestration & Micro-Services ---> Mesh
   D ---> D3
   D1 -.-> D
   D2 -.-> D
   P --> G
   Flutter --> B
   C --> Flutter -->|Auth endpoints| C
   B -->|API calls| D & Service1 & Service2
   D --> C & Service1 & Service2 & L
   Service1 --> DB-Service1 & L
   Service2 --> DB-Service2 & L
   Service1 -.-> Dapr1 --> C & L & P
   Service2 -.-> Dapr2 --> C & L & P
   L --> G
```
Chaque appel utilisateur transite d’abord par **Traefik** (reverse-proxy sécurisé + WAF), puis par **Temporal** pour les workflows (inscription, authentification, etc.) sans couplage direct entre microservices. **Keycloak** gère l’IAM, et **Linkerd** assure le chiffrement mutuel, l’équilibrage de charge et la résilience inter-services. Enfin, **Prometheus**, **Grafana** et **ElasticSearch** offrent une visibilité complète.

---

## Bonnes pratiques respectées

- **Database-per-Service** : chaque microservice possède sa propre base PostgreSQL, isolant les domaines fonctionnels.
- **Event-Driven Orchestration** : Temporal garantit l’atomicité et la reprise sur échec des workflows métier.
- **Zero-Trust & mTLS** : Linkerd maillant les services assure une authentification mutuelle et un chiffrement des communications internes.
- **Sécurité “By Design”** : WAF ModSecurity, rate-limiting, scopes OAuth2, introspection de jetons et certificats TLS.
- **Résilience** : patterns *retry*, *circuit breaker*, *health checks*, *bulkheads* et *scalabilité horizontale*.
- **12-Factor App** : configuration via variables d’environnement, logs sur stdout, stateless services, etc.
- **Observabilité** : métriques et logs centralisés pour un diagnostic rapide.

---

## Licence

Ce projet est distribué sous licence **MIT**. Consultez le fichier [`LICENSE`](./LICENSE) pour plus de détails.
