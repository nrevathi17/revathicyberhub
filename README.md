# Auto Network Defense System Against Brute Force Attacks

## 📌 Description
This project implements an automated network defense system that detects and blocks SSH brute-force attacks in real time.

Both are in same network using (VMware NAT)
## 🛠️ Tools & Technologies
- Kali Linux (Attacker Machine)
- RedHat Linux (Target Machine)
- Nmap (Network Scanning)
- Hydra (Brute-force attack simulation)
- Bash Scripting
- iptables (Firewall)
- Wireshark (Network Analysis)

## 🔍 Project Workflow
1. Attacker scans target using Nmap
2. Identifies open SSH port (22)
3. Launches brute-force attack using Hydra
4. Target system monitors logs for failed login attempts
5. Script extracts attacker IP
6. Firewall blocks attacker IP automatically
7. Attack stops
8. IP is auto-unblocked after 120 seconds
9. Wireshark verifies traffic behavior

## 🚀 Features
- Real-time attack detection
- Automatic IP blocking
- Auto-unblock mechanism
- Network traffic visualization
- Reconnaissance detection awareness

## ⚙️ Commands Used

### Nmap Scan
nmap 10.10.1.6

### Hydra Attack
hydra -l root -P /usr/share/wordlists/rockyou.txt -t 2 ssh://10.10.1.6

### Run Defense Script
sudo ./auto_block.sh

### Clear Old Data
sudo iptables -F

### Check Firewall
sudo iptables -L -n

## 📊 Result
- Attack detected and blocked successfully
- Unauthorized access prevented
- Network traffic stopped after blocking (verified using Wireshark)

