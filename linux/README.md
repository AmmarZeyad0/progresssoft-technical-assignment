# Linux Task 2: User and Group Management

## Objective
Create a Linux user named `PS` with `PSgroup` as the primary group and `dba` as a secondary group.

## Implementation
The user and groups were created on the Linux VM using Linux user and group management commands.

## Verification
The following commands are used to verify the configuration:

```bash
id PS
uid=1001(PS) gid=1001(PSgroup) groups=1001(PSgroup),1002(dba)
getent group PSgroup
PSgroup:x:1001:PS
getent group dba
dba:x:1002:PS
getent passwd PS
PS:x:1001:1001::/home/PS:/bin/sh
```

## Expected Result
- User `PS` exists.
- Primary group is `PSgroup`.
- Secondary group includes `dba`.
- The user account and both groups can be verified on the VM.

## Status
Pending verification of the current VM configuration.


# Linux Task 3: Modifey the Root Password

## Objective
Edit the Root Password

## Implementation
The user had been created without Password

## Verification

```bash
ammarz@ps-server:~$ sudo passwd root
[sudo: authenticate] Password:          
New password: 
Retype new password: 
passwd: password updated successfully
```

## Expected Result
- The User had been successfully change the password 
