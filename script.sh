#!/bin/bash

shopt -s extglob
#list of all features 
echo "Select 1 of the following:"
echo "(1). File Type Count"
echo "(2). Switch to Excecutable"
echo "(3). Find Tag"
echo "(4). Backup and Delete/Restore"
echo "(5). Git Push"
echo "(6). Creates a new executable bash file"
echo "(7). Checkout Latest Merge"
read opt

if [ $opt -gt 0 ] && [ $opt -lt 8 ] ; then 
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
        echo "Enter a Find Tag: "
        read ele
        TagFile="$ele.log"
        touch "$TagFile"
        cd .. 
        find . -name "*.py" | xargs egrep "#|$ele"  > Project01/"$TagFile"
    fi 
    if [ $opt -eq 4 ] ; then 
        echo "Backup and Delete/Restore"
        echo "Select one of the following options: "
        echo "(1). Backup and Delete "
        echo "(2). Restore "
        read usel
        if [ $usel -gt 0 ] && [ $usel -lt 3 ] ; then 
            if [ $usel -eq 1 ] ; then 
                if [ -d Backup ] ; then 
                    rm -r Backup    
                fi
                mkdir Backup
                touch ./Backup/restore.log
                find .. -name '*.tmp' -print0 |
                    while IFS= read -r -d '' line; do 
                        f="realpath $line"
                        cp $line ./Backup
                        $f >>  ./Backup/restore.log
                        rm $line
                     done
                echo "Backup Complete and Files Deleted"
            fi
            if [ $usel -eq 2 ] ; then 
                if [ -f ./Backup/restore.log ] ; then
                    while IFS= read -r line
                        do
                            sea=$(basename $line)
                            cd Backup
                            mv $sea $line  
                            cd ..
                        done < ./Backup/restore.log
                        rm -r Backup
                    echo "Files Restored"
                else 
                    echo "There is no Restore.log from!"
                fi 
            fi
        fi 
    fi
    if [ $opt -eq 5 ] ; then 
        echo "Git Push"
        echo "Choose one of the following options:"
        echo "(1). Commit Everything"
        echo "(2). Commit only main files and delete test files"
        read comc 
        if [ $comc -gt 0 ] && [ $comc -lt 3 ]; then 
            if [ $comc -eq 2 ]; then 
                rm -v !("script.sh"|"README.md"|"1XA3_Project01.pdf")
            fi
            git add -A 
            echo "Enter a Commit Message"
            read cmsg
            git commit -m"$cmsg"
            b=$(git rev-parse --abbrev-ref HEAD)
            git push origin $b
        else 
            echo "Invalid selection"
        fi
    fi
    if [ $opt -eq 6 ] ; then
        echo "Creates a new executable bash file"
        echo "Enter the file name with the desired Extention"
        read fname
        if [ ! -f $fname ]; then 
            if [[ $fname == *.sh ]] ; then 
                touch "$fname" 
                chmod 775 $fname
                echo "#!/bin/bash" > $fname
            else 
                touch "$fname"
                chmod 775 $fname 
            fi
        else 
            echo "There is already a file that exits with the same name!" 
        fi 
    fi 
    if [ $opt -eq 7 ] ; then 
        kw="merge"
        c=$(git log -i --grep="$kw" -1 --oneline | head)
        set - $c

        if [ -z ${1+x} ]; then
            echo "No commit found with keyword \"$kw\""
        else
            git checkout $1
        fi
    fi 
else
    echo "Invalid Input"
fi