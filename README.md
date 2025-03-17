# Personal tools and setup

Work in progress

## Github work and personal

- [x] Work github ssh
- [ ] mac bootstrap script
- [ ] rc files

### Create SSH keys for each github user

```shell
# You need to have an SSH key for each github user/account
echo "Creating SSH key for personal Github..."

# Generate
ssh-keygen -t ed25519 -C "lucas.gansberg@gmail.com"
# Start ssh-agent
eval "$(ssh-agent -s)"
# Add ssh to apple keychain (use keychain only if you gave a password)
ssh-add --apple-use-keychain ~/.ssh/personalGH
# ssh-add ~/.ssh/id_rsa_work # not using keychain ie password

# ----- Repeat for other account ---------
```

Next, add them to each user's Github settings (SSH Keys)

### SSH Config

Once, that is complete, update the `SSH config` to specify the SSH keys

> UseKeychain, AddKeysToAgent, etc are things to consider depending on the setup.  This is for a mac using Keychain.

```shell
# Github Work Account
Host git_work
  HostName github.com
  User git # user will be git regardless of your actual username
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/<key.pub>

# Github Personal account
Host git_personal
  HostName github.com
  User git # user will be git regardless of your actual username
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/<personalGH.pub>

```

#### Add keys

Need to register the SSH keys

```shell
# SSH add key
eval $(ssh-agent)
ssh-add --apple-use-keychain ~/.ssh/personal
ssh-add --apple-use-keychain ~/.ssh/work
```

### Committing as the correct user

We then modify our `~/.gitconfig` file to use our work account when we are inside a work-related repository. We are going to use “Conditional Includes” for that, which dynamically adds/removes configuration based on certain conditions.

```shell
[includeIf "gitdir:~/git/personal/**"]
  path = ~/git/personal/.gitconfig
  email = \<personal-email\>
[includeIf "gitdir:~/git/work/**"]
  path = ~/git/work/.gitconfig
  email = \<work-email\>
[init]
	defaultBranch = main
[user]
	name = Lucas Gansberg

```

This makes git override our global configs and use work@email.com when committing changes inside the work repository. When in any other repository, our personal account will be used.
