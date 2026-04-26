# IT_Homelabs
Hands on practice with Active Directory, DHCP, PowerShell, and most importantly troubleshooting

## Lab Environment
- **Hypervisor:** VirtualBox
- **Domain Controller:** Windows Server 2022 — LAB.local
- **Client Machine:** Windows 11 Pro
- **Domain:** LAB.local

## Projects

### Active Directory and PowerShell
| Project | Description | Skills Demonstrated |
|---|---|---|
| [Onboarding](./Active_Directory/Onboarding/) | Automated AD user creation from CSV | PowerShell, AD user/group management (all done via PS), CSV-driven workflows simulating HR data feeds, Audit logging and error handling (Try/Catch/Log), Identity lifecycle management |
| [Offboarding](./Active_Directory/Offboarding/) | Automated account disablement and cleanup | PowerShell, AD account management, OU structure, group membership cleanup, audit logging |
| [Notifications](./Active_Directory/Notifications/) | Automated email alerts for password expiry and account lockouts | PowerShell, AD queries, SMTP/email automation, scheduled alerting, admin + user notifications |

### Networking / Infra
| Project | Description | Skills Demonstrated |
|---|---|---|
| [DHCPServerLab](./Active_Directory/DHCPServerConfig/) | Deployed and configured Windows Server 2022 DHCP in an AD environment with multiple scopes, exclusions, reservations, and client lease validation | DHCP configuration, IP addressing & subnetting, scope design, reservations & exclusions, DNS integration |

### Ticketing System Troubleshooting
| Project | Description | Skills Demonstrated |
|---|---|---|
| [DNS Connectivity Issue](./SpiceWorks.pdf) | Simulated a user workstation unable to access websites or "internal" web-based apps (slack and outlook) due to DNS configuration issues | Spiceworks ticketing, DNS troubleshooting, `ipconfig`, `ping`, DNS cache flushing, user communication, ticket documentation, resolution verification |
| [Shared Drive Access Issue](./SpiceWorks.pdf/) | Simulated a user being unable to access a shared network drive after a recent password change | Spiceworks, network share troubleshooting, SMB path access, Windows Credential Manager, cached credentials, user password lifecycle awareness |

