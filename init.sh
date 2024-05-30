# set -e
CURRENT_SCRIPT_DIR=$(dirname "$(realpath "$0")")
# GITHUB_USERNAME=adrtivv
# install ansible if not found on the $PATH
# if ! command -v ansible > /dev/null; then
#   sudo dnf install -y ansible
# fi

# while true; do
#   echo "select an option:- "
#   echo "1. backup"
#   echo "2. restore"
#   echo "3. exit"
#   read option
#   case $option in
#     1)
      # ansible-playbook -K "$CURRENT_SCRIPT_DIR/backup/main.yaml"
#       chezmoi git commit -am "TT"
#       chezmoi git push origin main
#       break
#     ;;
#     2)
      ansible-playbook -K "$CURRENT_SCRIPT_DIR/restore/main.yaml"
#       # setup the source directory, generate the config file, and update 
#       # the destination directory to match the target state.
#       chezmoi init --apply https://github.com/$GITHUB_USERNAME/dotfiles.git
#       break
#     ;;
#     3)
#       exit 0
#     ;;
#     *)
#       echo "invalid option selected, try again"
#       continue
#     ;;
#   esac
# done
