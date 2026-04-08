  GNU nano 8.1                                       ./auto_block.sh                                                 
#!/bin/bash
#Varible LOG stores the path of the log file (RedHat security logs)
LOG="/var/log/secure"

# Monitor log file in real-time
tail -Fn0 $LOG | while read line; do
#tail -Fn0 --> Continuously monitor log file in real-time
# | while read line --> read each new line from log one by one
        # check if the current log line contains Failed password
        # > /dev/null --> hide output (we only care about match or not)
        echo "$line" | grep "Failed password" > /dev/null

        #If match found (exit status = 0); $? stores result of prev cmd; 0= success (pattern found)
        if [ $? = 0 ]; then

            #Extract attacker IP from log line;awk -> text processing tool;(NF-3) -> field where IP is located in log
            IP=$(echo $line | awk '{print $(NF-3)}')

            #check if IP is already blocked in iptables
            sudo iptables -L INPUT -v -n | grep $IP > /dev/null

            #if IP is not already blocked
            if [ $? != 0 ]; then

                #print message
                echo "[+] Blocking attacker IP: $IP"

                #Add rule to block attacker IP
                sudo iptables -A INPUT -s $IP -j DROP
                #Add firewall rule: -A INPUT -> incoming traffic; -s $IP -> source IP; -j DROP -> block completely

                #auto unblock safely 
                nohup bash -c "sleep 120 && sudo iptables -D INPUT -s $IP -j DROP && echo '[+] Unblocked $IP'" >/dev/null 2>&1 &
	   fi
	fi
done
