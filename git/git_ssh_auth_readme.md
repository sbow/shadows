Setup Github to use ssh key to do push/pull ect:

(assume ssh key generated / exists on local system)

check key exists:
eval `ssh-agent -s`
ssh-add -l -E md5

get public key:
cat ~/.ssh/id_rsa.pub

(log into github, paste contents into ssh keys)

change directory to cloned github repo:
cd ~/git/sbow/shadows

setup git to use ssh:
git remote set-url origin git@github.com:sbow/shadows.git

