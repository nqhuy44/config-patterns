# ArgoCD

- [ArgoCD](#argocd)
  - [1. Prerequisites](#1-prerequisites)
  - [2. Installation](#2-installation)
  - [3. RBAC](#3-rbac)
  - [4. User Management](#4-user-management)
  - [5. Notification](#5-notification)
  - [6. Troubleshooting](#6-troubleshooting)
  - [7. Contributing](#7-contributing)

---

## 1. Prerequisites
## 2. Installation
## 3. RBAC

Reference: https://argo-cd.readthedocs.io/en/stable/operator-manual/rbac/

| Resource        | get | create | update | delete | sync | action | override | invoke |
| --------------- | --- | ------ | ------ | ------ | ---- | ------ | -------- | ------ |
| applications    | ✅   | ✅      | ✅      | ✅      | ✅    | ✅      | ✅        | ❌      |
| applicationsets | ✅   | ✅      | ✅      | ✅      | ❌    | ❌      | ❌        | ❌      |
| clusters        | ✅   | ✅      | ✅      | ✅      | ❌    | ❌      | ❌        | ❌      |
| projects        | ✅   | ✅      | ✅      | ✅      | ❌    | ❌      | ❌        | ❌      |
| repositories    | ✅   | ✅      | ✅      | ✅      | ❌    | ❌      | ❌        | ❌      |
| accounts        | ✅   | ❌      | ✅      | ❌      | ❌    | ❌      | ❌        | ❌      |
| certificates    | ✅   | ✅      | ❌      | ✅      | ❌    | ❌      | ❌        | ❌      |
| gpgkeys         | ✅   | ✅      | ❌      | ✅      | ❌    | ❌      | ❌        | ❌      |
| logs            | ✅   | ❌      | ❌      | ❌      | ❌    | ❌      | ❌        | ❌      |
| exec            | ❌   | ✅      | ❌      | ❌      | ❌    | ❌      | ❌        | ❌      |
| extensions      | ❌   | ❌      | ❌      | ❌      | ❌    | ❌      | ❌        | ✅      |

## 4. User Management

Reference:
https://argo-cd.readthedocs.io/en/stable/operator-manual/user-management/

## 5. Notification
## 6. Troubleshooting
## 7. Contributing