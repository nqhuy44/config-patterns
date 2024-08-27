# ArgoCD

[1. Prerequisites](#1-prerequisites)
[2. Installation](#2-installation)
[3. RBAC](#3-rbac)
[4. User Management](#4-user-management)
[5. Troubleshooting](#5-troubleshooting)
[6. Contributing](#6-contributing)
ß
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

## 5. Troubleshooting
## 6. Contributing