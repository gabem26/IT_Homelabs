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

## Ticketing System Troubleshooting

Hands-on helpdesk simulations using Spiceworks to document, troubleshoot, resolve, and close realistic IT support tickets. These scenarios focused on real-world Tier 1/Tier 2 issues, including user communication, troubleshooting documentation, internal notes, and resolution summaries.

| Project | Description | Skills Demonstrated |
|---|---|---|
| [DNS Connectivity Issue](./Spiceworks/) | Simulated a user workstation unable to access websites or internal web-based tools due to DNS configuration issues. Troubleshot the issue using command-line tools, corrected DNS settings, flushed DNS cache, verified connectivity, updated the user, documented internal notes, and closed the ticket after confirmation. | Spiceworks ticketing, DNS troubleshooting, `ipconfig`, `ping`, DNS cache flushing, user communication, ticket documentation, resolution verification |
| [Shared Drive Access Issue](./Spiceworks/) | Simulated a user being unable to access a shared network drive after a recent password change. Troubleshot network share access, verified the share path, reviewed saved Windows credentials, reconnected using the current password, updated the saved credential, verified file access, and documented the resolution. | Network share troubleshooting, SMB path access, Windows Credential Manager, cached credentials, permissions awareness, user password lifecycle awareness, ticket lifecycle management |

