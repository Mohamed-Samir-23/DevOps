# LAB 3-2

***Change the permissions of oldpasswd file to give owner read and write***
```
chmod 631 oldpasswd

chmod u=rw,g=wx,o=x oldpasswd
```
![Getting Started](./Pictures/1.png)
***Change your default permissions to be as above***
```
umask 146
```
***What is the maximum permission a file can have, by default when it is just created? And what is that for directory ?***
```
with this default file has 620 mode but
with normal default 666 mode
and dir has default 631 mode but
with normal default 777 mode
```
![Getting Started](./Pictures/2.png)

***Change your default permissions to be no permission to everyone then create a directory and a file to verify***
```
umask 777
touch mynewfile1.txt
mkdir mynewdir1
ls -l |grep mynewfile1
ls -l |grep mynewdir1
```
![Getting Started](./Pictures/3.png)

***Minimum Permissions Needed***
```
- Copy a directory:

    • Source directory: Read and execute (r-x).
    • Target parent directory: Write and execute (wx).

- Copy a file:

Source file: Read (r--).
    • Target parent directory: Write and execute (wx).

- Delete a file:

    • File's parent directory: Write and execute (wx).

- Change to a directory:

    • Directory: Execute (x).

- List directory content:

    • Directory: Read (r--).

- View file content:

    • File: Read (r--).

-Modify a file content:

    • File: Write (w--).

```

***Create a file with permission 444. Try to edit in it and to remove it? Note what happened.***
```
touch test_task.txt
chmod 444 test_task.txt
rm test_task.txt
# conclusion with this mode file is readonly and we can't remove 
# because no Execute or Write Permissions
```
![Getting Started](./Pictures/5.png)
![Getting Started](./Pictures/4.png)

***What is the difference between the “x” permission for a file and for a directory?***
```
- File:

    • The x permission allows the file to be executed (e.g., running a script or binary).

- Directory:

    • The x permission allows you to enter the directory and access files within it.
```

***Using vi write your CV in the file mycv. Your CV should include your name, age, school,college, experience***
```
touch mycv.txt
vi mycv.txt 
cat mycv.txt 
```
![Getting Started](./Pictures/6.png)

***Open mycv file using vi command then: Without using arrows state how***
```
Move the cursor down one line at a time: 'j'
Move the cursor up one line at a time: 'k'
Move the cursor left one line at a time: 'h'
Move the cursor right one line at a time: 'l'
```
```
# Search for word age
/age
```
![Getting Started](./Pictures/7.png)

```
# Step to line 5 assuming that you are in line 1 
# and the file has more than 5 lines
5G
```

```
# Delete the line you are on and line 5.
5G
dd
```
![Getting Started](./Pictures/8.png)

```
# How to step to the end of line and change to writing mode in one-step.
A 
a
```
![Getting Started](./Pictures/9.png)

***List the available shells in your system***
```
cat /etc/shells
```
![Getting Started](./Pictures/10.png)

***List the environment variables in your current shell***
```
printenv
env
```
![Getting Started](./Pictures/11.png)

***List all of the environment variables for the bash shell***
```
declare -p
```
![Getting Started](./Pictures/12.png)

***What are the commands that list the value of a specific variable?***
```
export samirahmed=5
printenv samirahmed 
```
![Getting Started](./Pictures/13.png)

***Display your current shell name***
```
echo $SHELL
```
![Getting Started](./Pictures/14.png)

***Edit in your profile to display date at login and change your prompt permanently***
```
vim ~/.bashrc
echo "Login Date: $(date)"
PS1='\u@\h:\w\$ '
source ~/.bashrc
```
![Getting Started](./Pictures/15.png)
![Getting Started](./Pictures/16.png)

***Execute the following command : echo \ then press enter***
```
echo \
```
![Getting Started](./Pictures/17.png)

***how can you change it from “>” to “:”***
```
export PS2=": "
```
![Getting Started](./Pictures/18.png)

***Create a Bash shell alias named ls for the “ls –l” command***
```
alias ls='ls -l'
ls
```
![Getting Started](./Pictures/19.png)