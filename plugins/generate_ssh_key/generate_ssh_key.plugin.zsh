function generate_ssh_key() {
    echo "Generating a new SSH key for GitHub..."
    echo "Please enter your email address:"
    read email

    echo "Please enter a name for your SSH key:"
    read user

    # Generating a new SSH key
    # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
    ssh-keygen -t ed25519 -C $email -f ~/.ssh/$user

    # Adding your SSH key to the ssh-agent
    # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
    eval "$(ssh-agent -s)"

    echo "Host $user\n HostName github.com\n User $user\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/$2\n" | tee -a ~/.ssh/config

    ssh-add --apple-use-keychain ~/.ssh/$user

    touch ~/.ssh/known_hosts
    # Check if github.com is in known_hosts, and add it if it's not
    if ! ssh-keygen -F github.com >/dev/null; then
        ssh-keyscan github.com | tee ~/.ssh/known_hosts
    fi

    # Adding your SSH key to your GitHub account
    # https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
    echo "run 'pbcopy < ~/.ssh/$user.pub' and paste that into GitHub"
}
