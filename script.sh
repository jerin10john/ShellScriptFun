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
        echo "1"
    fi 
    if [ $opt -eq 2 ] ; then 
        echo "2"
    fi 
    if [ $opt -eq 3 ] ; then 
        echo "3"
    fi 
    if [ $opt -eq 4 ] ; then 
        echo "4"
    fi
else
    echo "Invalid Input"
fi 