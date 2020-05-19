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