# set PATH so it includes user's private personal_scripts if it exists (should rename to bin)

SCRIPT_DIR="personal_scripts"

echo "
# Set PATH so it includes user's private bin if it exists
if [ -d "\$HOME/${SCRIPT_DIR}" ] ; then
    PATH="\$HOME/${SCRIPT_DIR}:\$PATH"
fi" >> ~/.zshrc

source ~/.zshrc

cp ./scripts/* ~/${SCRIPT_DIR}
