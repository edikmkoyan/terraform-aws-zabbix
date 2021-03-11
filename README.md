# terraform-aws-zabbix

# Research the GitHub secret storage

The pair of keys can be generated with gpg. Here it is the docs:
	https://help.github.com/articles/generating-a-new-gpg-key/
The generation of the key can take very long time. It can seem that the laptop stops working.
To generate the key quickly, 'rng-tools' should be installed.
While facing this issue, the following articles can be helpful:
	- https://serverfault.com/questions/471412/gpg-gen-key-hangs-at-gaining-enough-entropy-on-centos-6
	- https://serverfault.com/questions/214605/gpg-does-not-have-enough-entropy

##Utilities

###Git-crypt
Here it is the github link:
	https://github.com/AGWA/git-crypt
Here it is the steps of the setup:
	- create .gitattributes, and write the filenames in it to be secret
	- add the gpg user
	- push the configurations to the repo, they will be encrypted
To see the list of the files before the push, do:
	git-crypt status -e

There are many disadvantages for git-crypt. The main disadvantage is that it is not foreseen for team project.

###Git-secret
This is good choice if the version of gpg is the same in the local and the integrated machines, otherwise the following issue can be raised: 
	 https://github.com/sobolevn/git-secret/issues/136
Here, the steps of usage can be found:
	 https://asciinema.org/a/41811


