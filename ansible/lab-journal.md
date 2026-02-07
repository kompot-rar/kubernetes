# Lab Journal: K3s High Availability & Kube-VIP Deployment
**Data:** 2026-02-07
**Status:** Sukces (Klaster HA Operacyjny)

## Cel
Konfiguracja klastra K3s w trybie High Availability (3 nody Control Plane) z wykorzystaniem Kube-VIP jako Floating IP (10.0.20.10) dla punktu dostępowego API Servera.

## Przebieg Prac

### 1. Refaktoryzacja Inwentarza
- Przeniesiono wszystkie jednostki (`k3s-master-0`, `k3s-worker-1`, `k3s-worker-2`) do grupy `masters`.
- Zmiana nazw hostów na spójne: `k3s-master-0`, `k3s-master-1`, `k3s-master-2`.

### 2. Rozwiązywanie Problemów z Migracją (Worker -> Master)
- **Problem:** Nody nie chciały dołączyć jako serwery, ponieważ miały zainstalowane komponenty agenta.
- **Rozwiązanie:** Stworzono playbook `reset_cluster.yaml` wykonujący pełny "Nuke & Pave" (odinstalowanie K3s, czyszczenie `/var/lib/rancher`).
- **Ulepszenie:** Dodano do roli `k3s_install` automatyczne wykrywanie i usuwanie agenta przed promocją do roli mastera.

### 3. Wdrożenie Kube-VIP (Control Plane HA)
- Zaimplementowano rolę `kube_vip` wdrażającą manifest Static Pod.
- **Problem diagnostyczny:** Brak pinga do VIP-a, błędy w logach: `dial tcp: lookup kubernetes on 1.1.1.1:53: no such host`.
- **Analiza:** Kube-VIP w trybie `hostNetwork` próbował rozwiązać nazwę `kubernetes` przez zewnętrzny DNS (router/Cloudflare).
- **Rozwiązanie (The "Host Alias" Hack):** Dodano `hostAliases` do manifestu Kube-VIP, mapując `kubernetes` na `127.0.0.1`. To wymusiło połączenie z lokalnym API Serverem i natychmiast aktywowało Floating IP.

## Stan Końcowy
- **VIP Address:** `10.0.20.10` (pinguje, obsługuje ruch API).
- **Quorum:** 3 nody etcd działają poprawnie.
- **Dostęp:** Lokalny `kubectl` skonfigurowany pod adres VIP, co zapewnia dostęp nawet po padzie jednego z masterów.

## Komendy Diagnostyczne (Cheat Sheet)
```bash
# Sprawdzenie kto trzyma VIP
ansible masters -i inventory.yaml -m shell -a "ip addr show eth0 | grep 10.0.20.10" --become

# Logi Kube-VIP
kubectl logs -n kube-system -l app.kubernetes.io/name=kube-vip

# Sprawdzenie stanu etcd
kubectl get nodes
```

---
*Notatka mentora: Pamiętaj, że `hostAliases` to potężne narzędzie przy debugowaniu usług systemowych wewnątrz klastra, które muszą gadać same ze sobą przed pełnym wstaniem DNS.*
