## lecture

***create script in bash:***
```
vi llab1.sh

#--------------------file-------------------------
#!/bin/bash
ls
whoami
date
#-------------------------------------------------

file llab1.sh
#llab1.sh: Bourne-Again shell script, ASCII text executable 
#executable added by using shebang to description
#also bash make this shell run in child shell

sh llab1.sh

chmod +x  

./llab1.sh

#append my location to path not recommended security ways
PATH=.:$PATH

llab1.sh
```
***create script in python3:***
```
vi llab2.py

#--------------------file-------------------------
#!/bin/python3
print("hello samir")
#-------------------------------------------------

chmod +x llab2.py

./llab2.py

#if you don't know location of python 3 use
#!/bin/env python3
```

***comment in bash:***
```
single comment in bash

#comment

multiline-comment in bash

<<samir
comment
comment
samir
```

***printf vs echo ***
```
vi llab3.sh
#--------------------file-------------------------
#without new line \n
printf "hello"
#with new line \n
echo "hello"
#-------------------------------------------------

chmod +x  

./llab3.sh
```

***read input***
```
vi llab4.sh
#--------------------file-------------------------
#!/bin/bash
read -p "enter your name : " userInput
#to hide input
read -sp "enter your pass :" password
echo 
echo "hello $userInput"
echo "your password is $password"
#-------------------------------------------------
chmod +x  

./llab4.sh
```

***debug mode***
```
set -x
#code
set +x
```


***Local & Global variable***
```
#local
a="1234"
#Global scope to all child shell
export b="5678"

#to share from child to parent also will take local and global from parent
x="500"

source ./llab5.sh or . ./llab5.sh

vi llab5.sh
#--------------------file-------------------------
#!/bin/bash
echo $a
echo $b
x="500"
#-------------------------------------------------
chmod +x  
source ./llab5.sh
./llab5.sh

```