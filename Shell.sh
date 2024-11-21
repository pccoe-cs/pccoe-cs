
//shell.sh


clear
while [ 1 ]
do
echo 1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit

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
echo "Recoed Inserted Successfully "
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
echo -n "Ente new roll number and new name : "
read nroll nname
grep -w "$nname" $fname
ans=$?
if [ $ans -eq 0 ]
then
echo "Record already exists please tru another roll no "
else
grep -v "roll" $fname >> temp
echo "$nroll" $nname >> temp
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
grep -v "$roll" $fname >> temp
rm $fname
cp temp $fname
rm temp
echo "Recod successfully deleted"
else
echo "Record doesnot found"
fi
else
echo "File not found"
fi
;;
7)exit
;;
8) echo "Your choice is not correct "
;;
esac
done


//output

1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
1
Enter File name :
First.txt
File Create Successfully..
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
3
Enter file name :
First.txt
Enter the roll no. : 1
answer=1
Enter name :ABC
Recoed Inserted Successfully
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
3
Enter file name :
First.txt
Enter the roll no. : 2
answer=1
Enter name :XYZ
Recoed Inserted Successfully
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
3
Enter file name :
First.txt
Enter the roll no. : 3
answer=1
Enter name :PQR
Recoed Inserted Successfully
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
2
Enter the file name
First.txt
The content of file
1 ABC
2 XYZ
3 PQR
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
4
Enter the file name : First.txt
Enter the roll no : 2
2 XYZ
Record found
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
5
Enter the file name : First.txt
Enter the roll no : 3
3 PQR
Ente new roll number and new name : 4 LHK
Record successfully modified
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
2
Enter the file name
First.txt
The content of file
1 ABC
2 XYZ
4 LHK
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
6
Enter the file nameFirst.txt
Enter roll number4
4 LHK
Recod successfully deleted
1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
2
Enter the file name
First.txt
The content of file
1 ABC
2 XYZ

1.Create 2.Display 3.Insert 4.Search 5.Modify 6.Delete 7.Exit
Enter Choice :
7
