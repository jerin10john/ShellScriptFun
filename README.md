# ShellScriptFun 

This Shell Script project was made and designed for a project in the COMPSCI 1XA3 at McMaster Univerity. The objective of this project is to evaluate my proficieny in using Bash to make simple and easy script. 
<br>

## Usage 
Start by running the following script from the directory where the ***script.sh*** file exists. 
        
        chmod 775 project_analyze.sh <br>
        ./project_analyze.sh
   The user will be prompted the following options :

        Select 1 of the following: 
        (1). File Type Count 
        (2). Switch to Executable
        (3). Find tag
        (4). Backup and Delete / Restore
        (5). Git Push 
        (6). Create a new executable bash file 
        (7). Checkout Latest Merge 
        (8). Fixme Log
        (9). File Size List 


   After this promt the user can run the feature by entering any of the corresponding numbers to run the feature. For example, entering ***"5"*** would execute the ***"Git Push"*** Feature. <br>

   ## Features

   ### 1. File Type Count 
   The feature is designed to count the number of files in a directory which end with the extention specified by the user. <br>
   ### 2. Switch to Execut able 
   The feature is used to find all the bash files in the curent directory and its sub-directory, and it changes its permission to executable. Before making the switch it checks if the user has write permission, and only if the user has write permissions does the feature change the permssion. The feature also has a log of all the original permissions of all files, so it can be restored at any time.<br>
   ### 3. Find tag 
   This feature promts the user to enter the word, and then searchs all the Python files in the directory and sub-directories. It creates a log and puts all the lines in the log.<br>
   ### 4. Backup and Delete / Restore 
   This feature creates a backup of every file in the directory ending with the file extention ***".tmp"***. Once the backup is created, the file is deleted from its original location. The feature also has a restore option, which then restores the file back to its original location and deletes the backup.<br>
   ### 5. Git Push 
   This feature allows the user to commit and push all the files to GitHub or it only pushes the predefined primary files to GitHub and deletes all the other files assuming they are test files, helping maintain a clean repo<br>
   ### 6. Create a new executable bash file 
   This feature creates a new file with executable permissions. If the file is a bash file, it adds ***"!/bin/bash"*** to the top of the file.<br>
   ### 7. Checkout Latest merge
   This feature is designed to find the latest commit with the commit message that contains the word ***"merge"***. Once found, the feature checksout to that branch.<br>
   ### 8. Fixme Log 
   This feature searches the current directory and all the sub-directories for all files with ***"#FIXME"*** in the last line of the file. The respective files are stored in a log called ***"fixme.log"***.<br>
   ### 9. File Size List 
   This feature lists the size of everyfile in greatest to smallest in human readable format.<br>  