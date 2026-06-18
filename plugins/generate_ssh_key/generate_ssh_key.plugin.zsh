function sshkey() {
    echo "Please enter your email address:"
    read email

    echo "Please enter a name for your SSH key (used as filename and Host alias):"
    read key_name

    echo "Please enter the git server hostname (e.g. github.com, gitlab.com, bitbucket.org):"
    read host

    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/$key_name

    eval "$(ssh-agent -s)"

    printf "\nHost %s.%s\n HostName %s\n User git\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/%s\n" \
        "$key_name" "$host" "$host" "$key_name" | tee -a ~/.ssh/config

    ssh-add --apple-use-keychain ~/.ssh/$key_name

    touch ~/.ssh/known_hosts
    if ! ssh-keygen -F "$host" >/dev/null; then
        ssh-keyscan "$host" | tee -a ~/.ssh/known_hosts
    fi

    pbcopy < ~/.ssh/$key_name.pub
    echo "SSH public key for $host has been copied to the clipboard."
    echo "Add it to your account at https://$host"
}
