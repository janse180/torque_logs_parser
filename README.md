# Torque Log Parser
This script takes a file of Adaptive Computing Torque logs and parses it to CSV.
## Usage
1. Enter the torque log diretory. 
```bash 
cd /var/spool/torque/server_logs
```
2. Concatinate all logs into a single file
```bash
cat * > logs.out
```

3. Feed the file into the parser script. 
```bash
./parse_torque_log.sh logs.out
```

4. The script will output a file named out.csv which contains the parsed data. 




