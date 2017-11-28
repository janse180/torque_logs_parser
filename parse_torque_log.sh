#!/bin/bash

log_file=$1
grep Exit $log_file > log_file_exit

csv_file=out.csv

echo "DateTime, Job ID, User ID, Job Name, Queue Name, Nodes Requested, PPN Requested, Wall Time Requested, CPU Time Used, Wall Time Used" > out.csv

IFS=$'\n'

total_line=`wc -l log_file_exit`
current_line=0

while read line; do

    date=`echo $line | cut -f1 -d";"`
    job_id=`echo $line | cut -f3 -d";"`
    user_id=`echo $line | cut -f4 -d ";" |cut -f1 -d " " | grep -o "=.*" | tr -d "="`
    job_name=`echo $line | cut -f4 -d ";" |cut -f4 -d " " | grep -o "=.*" | tr -d "="`
    queue_name=`echo $line | cut -f4 -d ";" |cut -f5 -d " " | grep -o "=.*" | tr -d "="`
    nodes_requested=`echo $line | cut -f4 -d ";" |cut -f12 -d " " | grep -o "[0-9]." | cut -f1 -d$'\n'`
    ppn_requested=`echo $line | cut -f4 -d ";" |cut -f12 -d " " | grep -o "[0-9]." | cut -f2 -d$'\n'`
    wall_time_requested=`echo $line | cut -f4 -d ";" |cut -f15 -d " " | grep -o "=.*" |tr -d "=" |awk -F: '{ print $1 + ($2/60) + ($3/60/60) }'`
    cpu_time_used=`echo $line | cut -f4 -d ";" |cut -f19 -d " " | grep -o "=.*" |tr -d "=" |awk -F: '{ print $1 + ($2/60) + ($3/60/60) }'`
    wall_time_used=`echo $line | cut -f4 -d ";" |cut -f22 -d " " | grep -o "=.*" |tr -d "=" |awk -F: '{ print $1 + ($2/60) + ($3/60/60) }'`

    echo "$date, $job_id, $user_id, $job_name, $queue_name, $nodes_requested, $ppn_requested, $wall_time_requested, $cpu_time_used, $wall_time_used" >> out.csv

    echo "Line $current_line of $total_line"
    ((current_line++))

done < log_file_exit
rm log_file_exit