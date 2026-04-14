# IT_Homelabs
Hands on practice with Active Directory/Azure, DHCP, PowerShell, and most importantly troubleshooting

## Lab Environment
- **Hypervisor:** VirtualBox
- **Domain Controller:** Windows Server 2022 — LAB.local
- **Client Machine:** Windows 11 Pro
- **Domain:** LAB.local

## Projects

### Active Directory
| Project | Description | Skills Demonstrated |
|---|---|---|
| [Onboarding](./Active_Directory/Onboarding/) | Automated AD user creation from CSV | PowerShell, AD user/group management (all done via PS), CSV-driven workflows simulating HR data feeds, Audit logging and error handling (Try/Catch/Log), Identity lifecycle management (Onboard and Offboard in this case) |
| [Offboarding](./Active_Directory/Offboarding/) | Automated account disabling and cleanup | PowerShell, AD user/group management (all done via PS), CSV-driven workflows simulating HR data feeds, Audit logging and error handling (Try/Catch/Log), Identity lifecycle management (Onboard and Offboard in this case) |

### Networking / Infra

| Project | Description | Skills Demonstrated |
|---|---|---|
| [DHCPServerLab](./Active_Directory/DHCPServerConfig/) | Deployed and configured Windows Server 2022 DHCP in an AD environment with multiple scopes, exclusions, reservations, and client lease validation | DHCP configuration, IP addressing & subnetting, scope design, reservations & exclusions, DNS integration |



