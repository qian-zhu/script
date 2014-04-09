#!/bin/bash
scp ~/.ssh/id_rsa.pub  $1@$2:~/
ssh $1@$2 " touch ~/.ssh/authorized_keys ; cat ~/id_rsa.pub  >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys; exit"
