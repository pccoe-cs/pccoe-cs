#!/bin/bash

clear

while [ 1 ]
do
    echo "1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit"
    echo "Enter Choice : "
    read ch

    case $ch in
        1)
            echo "Enter File name :"
            read fname
            if [ -e $fname ]
            then
                echo "File already exists"
            else
                >>$fname
                echo "File Create Successfully.."
            fi
        ;;

        2)
            echo "Enter the file name"
            read fname
            if [ -e $fname ]
            then
                echo "The content of file "
                sort -n $fname
            else
                echo "file not exists : "
            fi
        ;;

        3)
            echo "Enter file name : "
            read fname
            if [ -e $fname ]
            then
                echo -n "Enter the roll no. : "
                read roll
                grep -w "$roll" $fname
                ans=$?
                echo answer=$ans
                if [ $ans -eq 0 ]
                then
                    echo "Record Already exists "
                else
                    echo -n "Enter name :"
                    read name
                    echo "$roll $name" >> $fname
                    echo "Record Inserted Successfully "
                fi
            else
                echo "File not found "
            fi
        ;;

        4)
            echo -n "Enter the file name : "
            read fname
            if [ -e $fname ]
            then
                echo -n "Enter the roll no : "
                read roll
                grep -w "$roll" $fname
                ans=$?
                if [ $ans -eq 0 ]
                then
                    echo "Record found"
                else
                    echo "Record not found"
                fi
            else
                echo "File not found"
            fi
        ;;

        5)
            echo -n "Enter the file name : "
            read fname
            if [ -e $fname ]
            then
                echo -n "Enter the roll no : "
                read roll
                grep -w "$roll" $fname
                ans=$?
                if [ $ans -eq 0 ]
                then
                    echo -n "Enter new roll number and new name : "
                    read nroll nname
                    grep -w "$nname" $fname
                    ans=$?
                    if [ $ans -eq 0 ]
                    then
                        echo "Record already exists, please try another roll no."
                    else
                        grep -v "$roll" $fname > temp
                        echo "$nroll $nname" >> temp
                        rm $fname
                        cp temp $fname
                        rm temp
                        echo "Record successfully modified"
                    fi
                else
                    echo "Record not present"
                fi
            else
                echo "File not exists"
            fi
        ;;

        6)
            echo -n "Enter the file name"
            read fname
            if [ -e $fname ]
            then
                echo -n "Enter roll number"
                read roll
                grep -w "$roll" $fname
                ans=$?
                if [ $ans -eq 0 ]
                then
                    grep -v "$roll" $fname > temp
                    rm $fname
                    cp temp $fname
                    rm temp
                    echo "Record successfully deleted"
                else
                    echo "Record does not found"
                fi
            else
                echo "File not found"
            fi
        ;;

        7)
            exit
        ;;

        8)
            echo "Your choice is not correct "
        ;;

    esac
done
