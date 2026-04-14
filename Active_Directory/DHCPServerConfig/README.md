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
| Client Machine | Windows 11 — finance_user1 |
| Domain | LAB.local |
| DC Static IP | 192.168.56.10 |
| Network Type | VirtualBox Host-Only Ethernet Adapter -- Adapter 1  & NAT -- Adapter 2 |
