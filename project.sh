#!/bin/bash
<<doc
Name: Manikanda Bharathi T
Date: 30 June 2023
Title: Command Line Test
doc
function database() {
user=(`cat usernames.csv`)
pass=(`cat passwords.csv`)
}
database

function signup() {
  k=0 
  while [ $k -eq 0 ]
  do
      flag=0
      read -p "Enter the Username: " username
      for x in ${user[@]}
      do
         if [ "$x" == "$username" ]
         then
	    flag=1
	 fi
      done
         if [ $flag -eq 1 ]
         then
	    echo "Username already exist, Please enter valid username"         
         elif [ $flag -eq 0 ]
         then
            read -s -p "Enter the Password: "  type
            echo
	    read -s -p "Confirm Password: " retype
	    echo
            if [ $type == $retype ]
            then
              echo $username >> usernames.csv
              echo $type >> passwords.csv
              tput bold
	      echo "Account Created Successfully :)"         
	      tput sgr0
              database	  
	      k=1
            else
              echo "Error: Password not matched"
	      echo "Please enter valid password"
	    fi
          fi
   done
}


function signin() {
    m=0
    while [ $m -eq 0 ]
    do
    read -p "Enter the Username: " username
    flag=0
    for y in `seq 0 $((${#user[@]}-1))`
    do
	if [ "${user[$y]}" == "$username" ]
	then
	    flag=1 
	    break
	fi
    done
      #  if [ $flag -eq 0 ]
      #	then
      #	       echo "Username doesn't exist"
      if [ $flag -eq 1 ] || [ $flag -eq 0 ]
	then
	    read -s -p "Enter the Password: " password
             if [ $password == ${pass[$y]} ] && [ $flag -eq 1 ]
             then 
	         tput bold
		 echo "Sign in successfully  completed :)"
		 tput sgr0
                 if [ -f $username.csv ]
                 then
                 tput bold
                 echo "You already finished the test !"              
                 tput sgr0
		 Total
		 Review
		 m=1
                 else
	         echo "1.Take the test"
	         echo "2.Exit this page"
	         read -p "Enter your way: " way
	         case $way in
	         1)	     
	    	         Test
			 Total
			 Review			 
		      	 ;;
                 2) echo Exited the signin page
		     m=1
		      ;;
	     esac
		 fi
            else
	       echo "Username or Password is incorrect. Please enter correct username and password"
	    fi
	fi
    done
}

function Time() {
for i in `seq 10 -1 1`
do
    echo -ne "\rEnter the option ($i):  "
    read -t 1 option
    if [ -n "$option" ]
    then
	      break
    else
      	option='e'
    fi
done
}

function Test(){
     echo "------Test Page------" | lolcat 
     touch $username.csv
     head -5 questions.txt 
     Time
     case $option in
	 a) echo '$#' >> $username.csv ;;
	 b) echo '$n' >> $username.csv ;;
	 c) echo '$$' >> $username.csv ;;
	 d) echo '$@' >> $username.csv ;;
	 e) echo Timeout ; echo 'Timeout' >> $username.csv ;; 
	 *) echo 'empty' >> $username.csv ;;
     esac
     head -10 questions.txt | tail -5 
     Time
          case $option in
	 a) echo '@$' >> $username.csv ;;
	 b) echo '$*' >> $username.csv ;;
	 c) echo '#!' >> $username.csv ;;
	 d) echo '!#' >> $username.csv ;;
	 e) echo Timeout ; echo 'Timeout' >> $username.csv  ;;
	 *) echo 'empty' >> $username.csv ;;
	 esac
  head -15 questions.txt | tail -5 	 
  Time
    case $option in
    a) echo 'split_file' >> $username.csv ;;
    b) echo 'display_the_content_of_the_file' >> $username.csv ;;
    c) echo 'compare_the_files' >> $username.csv ;;
    d) echo 'delete_the_content_of_the_file' >> $username.csv ;;
    e) echo Timeout ; echo 'Timeout' >> $username.csv ;;
    *) echo 'empty' >> $username.csv ;;
   esac

}

function Total()
{   
    count=0
    entered=(`cat $username.csv`)
    answers=(`cat answers.csv`)
    for i in `seq 0 $((${#answers[*]}-1))`
    do
	if [ ${answers[$i]}  == ${entered[$i]} ]
	then
	    count=$(($count+1))
	fi
    done
    echo "Your Mark (out of 3) is: " $count    | lolcat
}

function Review()
{ read -p "Do you want to review your answers(y/n) :" rev
    case $rev in
      y) echo  "------Review Page------" | lolcat
  q=5	  
for b in `seq 0 $((${#answers[@]}-1))`
  do 
     head -$q questions.txt | tail -5
      if [ ${answers[$b]} == ${entered[$b]} ]
      then
         echo "Your answer is `tput smul; echo -n "${entered[$b]}" ; tput rmul` That's correct one."
     elif [ ${entered[$b]} == "Timeout" ]
     then
	 echo "Timeout for this question"
       else 
         echo "You entered $`tput smul; echo -n "${entered[$b]}" ; tput rmul` But correct one is `tput smul; echo -n "${answers[$b]}" ; tput rmul`"
      fi
      q=$((v+5))
 done
 read -p "Do you want to open main page(y/n) ? " continue
 case $continue in
     y) main 
        m=1 ;;
     n) tput bold;  echo "Exited Successfully :) " | lolcat; tput sgr0
	  i=0  
	  m=1
	   
	     ;;
      esac
      ;;
   
   n) tput bold;  echo "Exited Successfully :) " |lolcat; tput sgr0
	  m=1
 	   ;;
  esac
}

function main() {
i=1
while [ $i == 1 ]
do
    echo -e "\e[1;33m1.Signup"     
    echo "2.Signin"     
    echo -e "3.Exit\e[0m"        

read -p "Enter the Choice: " main
case $main in
    1) echo "------Signup Page------"  | lolcat
	signup   ;;
    2) echo "------Signin Page------"  | lolcat
	signin ;;
   3)  tput bold ; echo "Exited Sucessfully :)" | lolcat ; tput sgr0
       break	;;
   *) echo "Enter the valid Choice (1/2/3) only." ;;
esac
done
}
tput rev; tput bold; echo "The Command Line Test"; tput sgr0
main
