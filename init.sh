#!/bin/bash

set -e
current_script_dir=$(dirname "$(realpath "$0")")
# make sure ansible is installed
command -v ansible > /dev/null 2>&1
# install ansible if not found on the $PATH
if [ $? -ne 0 ];then
  sudo dnf install -y ansible
fi

while true; do
  echo "select an option:- "
  echo "1. backup"
  echo "2. restore"
  echo "3. exit"
  read option
  case $option in
    1)
      ansible-playbook -K "$current_script_dir/backup/main.yaml"
      chezmoi git commit -am "TT"
      chezmoi git push origin main
      break
    ;;
    2)
      ansible-playbook -K "$current_script_dir/restore/main.yaml"
      # setup the source directory, generate the config file, and update 
      # the destination directory to match the target state.
      chezmoi init --apply https://github.com/$GITHUB_USERNAME/dotfiles.git
      break
    ;;
    3)
      exit 0
    ;;
    *)
      echo "invalid option selected, try again"
      continue
    ;;
  esac
done
