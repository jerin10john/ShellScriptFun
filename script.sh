#!/bin/bash

shopt -s extglob
#list of all features 
echo "Select 1 of the following:"
echo "(1). File Type Count"
echo "(2). Switch to Excecutable"
echo "(3). Find Tag"
echo "(4). Backup and Delete/Restore"
read opt

if [ $opt -gt 0 ] && [ $opt -lt 5 ] ; then 
    if [ $opt -eq 1 ] ; then 
        echo "File Type Count"
        echo "Enter the file type: "
        read ftype
        echo "The number of $ftype files are:"
        find . -name "*.$ftype" | wc -l
    fi 
    if [ $opt -eq 2 ] ; then 
        echo "Switch to Executable"
        echo "Select one of the following options :"
        echo "(1). Change permissions"
        echo "(2). Recover to original permissions"
        read corr 
        if [ $corr -gt 0 ] && [ $corr -lt 3 ] ; then 
            if [ $corr -eq 1 ] ; then 
                if [ -f permissions.log ] ; then 
                    rm permissions.log 
                fi 
                touch permissions.log 
                find .. -name '*.sh' -print0 |
                    while IFS= read -r -d '' linez; do 
                        fsh=$(realpath $linez)
                        p=$(stat -c "%a" $linez)
                        echo "$p $fsh" >> permissions.log 
                        ow=$(( $p / 100 % 10 ))
                        g=$(( $p / 10 % 10 ))
                        ot=$(( $p % 10 ))
                        perarray=($ow $g $ot)
                        count=0
                        for per in ${perarray[@]}; do
                            if [ $per -eq 1 ] ; then 
                                perarray[$count]=0
                            fi 
                            if [ $per -eq 2 ] ; then 
                                perarray[$count]=3;
                            fi
                            if [ $per -eq 5 ] ; then 
                                perarray[$count]=4 
                            fi 
                            if [ $per -eq 6 ] ; then 
                                perarray[$count]=7
                            fi
                            count=$((count + 1))
                        done  
                        now=$(( ${perarray[0]} * 100 ))
                        ng=$(( ${perarray[1]} * 10 ))
                        nperm=$(( $now + $ng + ${perarray[2]} ))
                        chmod $nperm $fsh
                    done
                echo " Permissions Changed "
            fi 
            if [ $corr -eq 2 ] ; then 
                while IFS= read -r line; do 
                    chmod $line 
                done < permissions.log
                echo "Restored"
            fi 
        fi 
    fi 
    if [ $opt -eq 3 ] ; then 
        echo "Find Tag"
    fi 
    if [ $opt -eq 4 ] ; then 
        echo "Backup and Delete/Restore"
    fi
else
    echo "Invalid Input"
fi 