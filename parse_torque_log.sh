#!/bin/bash

log_file=$1
log_file_parsed=`grep Exit $log_file`

csv_file=out.csv

echo "Date, Time, Job ID, User ID, CPU Time, Wall Time" > out.csv

IFS=$'\n'
for line in $log_file_parsed
do
    date=`echo $line | cut -f1 -d" "`
    time=`echo $line | cut -f1 -d";" | cut -f2 -d" "`
    jobid=`echo $line | cut -f5 -d";"`
    cput=`echo $line | cut -f3 -d" " | grep -o '=.*' | tr -d =`
    wallt=`echo $line | cut -f6 -d" " | grep -o '=.*' | tr -d =`
    
    userid=`cat $log_file | grep $jobid | grep "Job Queued at" | cut -f7 -d" " | cut -f1 -d"@"`
    
    echo "$date, $time, $jobid, $userid, $cput, $wallt" >> out.csv 



    
    #date="${awk -F';' '{print $3}'}"
    #echo $date
done



#10/24/2016 10:04:02;0010;PBS_Server;Job;91713.aegean;Exit_status=0 resources_used.cput=00:02:56 resources_used.mem=1213864kb resources_used.vmem=2932444kb resources_used.walltime=00:01:30
