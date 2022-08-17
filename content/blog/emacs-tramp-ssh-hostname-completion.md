---
Title: Emacs Tramp SSH Hostname Completion
Date: 2022-08-17T19:00:00+03:00
Author: Aşkın Özgür
tags: ["emacs", "ssh"]
Slug: emacs-tramp-ssh-hostname-completion
Status: published
---

I store `ssh` configurations in separate files with categories. Forexample personal servers and work related servers are stored different files. `Include` directive is used to define external files in `~/.ssh/config`.
A configuration like below is very useful.

```ssh-config
# ~/.ssh/ssh_config_company1
Host top-secret-prod-host
  Hostname prod.example.com
  User root
  
# ~/.ssh/ssh_config_company2
Host top-secret-dev-host
  Hostname dev.example.com
  User root

# ~/.ssh/config
Include ssh_config_company1
Include ssh_config_company2
```

But with default configuration, `emacs tramp` hostname auto completion is not working. When I use full name of the host, it connects to machine successfuly. But when try to complete hostname with `TAB`, it is not working. After a little research, I lost my all hopes to fix the problem. But I saw a configuration on a unrelated stackoverflow post. When I try, it fixed the my problem.

```elisp
(tramp-set-completion-function
 "ssh"
 '((tramp-parse-sconfig "/etc/ssh_config")
   (tramp-parse-sconfig "~/.ssh/config")))
```

It could be useful when similar problems.

<!--more-->
