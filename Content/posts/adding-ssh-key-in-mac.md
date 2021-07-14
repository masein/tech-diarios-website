---
date: 2021-05-12 17:23
tags: techDiarios, SSH key, macOS
---
# Adding your SSH key to the ssh-agent in macOS

## You have two options in order to use your IaaS which SSH keys are prefered, here we have a quick tutorial on adding them to ssh-agent in order to access server 

1. open your terminal and start the ssh-agent in background.  

```  

 eval "$(ssh-agent -s)"
 
```    
2. as I didn't have config in ~/.ssh I created the file.  

```

touch ~/.ssh/config

```  

3. now in config file add the following lines and the path of your private key.  

```

Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/privateKeyName.pem
  
```  

4. Add your SSH private key to the ssh-agent  

```

ssh-add -K ~/.ssh/privateKeyName

```  
