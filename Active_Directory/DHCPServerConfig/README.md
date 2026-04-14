# DHCP Server Configuration
Deploys and configures a Windows Server 2022 DHCP server in an Active Directory environment with multiple scopes, exclusions, reservations, and live lease testing on a domain-joined Windows 11 client.

## What It Does
 
* Installs and authorizes the DHCP Server role in Active Directory
* Creates multiple scopes representing segmented corporate networks (Users, Voice, Guest)
* Configures exclusions within each scope to protect infrastructure IPs
* Sets per-scope DHCP options (default gateway, DNS server, DNS domain name)
* Adjusts lease durations based on device type and network segment
* Creates a DHCP reservation for a domain-joined client by MAC address
* Enables conflict detection to prevent duplicate IP assignments
* Verifies end-to-end lease delivery using a live Windows 11 client
 
## Lab Environment
 
| Component | Details |
|---|---|
| Hypervisor | VirtualBox |
| Domain Controller | Windows Server 2022 — DC01 |
| Client Machine | Windows 11 — finance_intern1 |
| Domain | LAB.local |
| DC Static IP | 192.168.56.10 |
| Network Type | VirtualBox Host-Only Ethernet Adapter -- Adapter 1  & NAT -- Adapter 2 |


## Scope Details
 
**Users LAN — 192.168.1.0/24**
- Range: 192.168.1.10 – 192.168.1.200
- Exclusion: 192.168.1.10 – 192.168.1.20 (printers, APs, static infrastructure)
- Options: Gateway 192.168.1.254 \| DNS 192.168.56.10 \| Domain LAB.local
 
**Corporate Voice — 192.168.2.0/24**
- Range: 192.168.2.10 – 192.168.2.150
- Exclusion: 192.168.2.10 – 192.168.2.30 (voice gateways, call managers)
- Options: Gateway 192.168.2.254 \| DNS 192.168.56.10 \| Domain LAB.local
 
**Guest Wi-Fi — 192.168.3.0/24**
- Range: 192.168.3.50 – 192.168.3.250
- Exclusion: 192.168.3.50 – 192.168.3.60 (wireless controllers, captive portal appliances)
- Options: Gateway 192.168.3.254 \| DNS 192.168.56.10 \| Domain LAB.local
 
**Lab Network — 192.168.56.0/24**
- Range: 192.168.56.50 – 192.168.56.200
- Exclusion: 192.168.56.50 – 192.168.56.60
- Reservation: finance_user1 → 192.168.56.100 (MAC: 08-00-27-86-3C-1F in my case)
- Options: Gateway 192.168.56.1 \| DNS 192.168.56.10 \| Domain LAB.local

**Note:** In a prod env, the Users LAN, Corporate Voice, and Guest Wi-Fi scopes would receive relayed DHCP requests via `ip helper-address` configured on Layer 3 switches or routers at each subnet boundary

## Requirements
 
* Windows Server with Active Directory Domain Services
* DHCP Server role installed and authorized in AD
* Static IP configured on the domain controller before DHCP role installation
* VirtualBox built-in DHCP disabled if using a Host-Only or Internal network adapter
