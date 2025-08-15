fastfetch
eval "$(starship init fish)"

function ansible-server-update
	echo "🔐 Enter SSH password for nextcloud:"
	read -s sudo_pass

	# set env vars temporaily for sshpass and Ansible
	set -x ANSIBLE_BECOME_PASS $sudo_pass
	set -X ANSIBLE_ASK_PASS True
	set -x SSHPAS $sudo_pass

	#save current directory
	set oldpwd (pwd)

	# change to project directory
	cd ~/projects/ansible

	echo "📦 Running full update on all servers (key-based)..."
	# First command: SSH key-based for all (except nextcloud)
	ansible-playbook playbooks/apt.yml --ask-become-pass -i inventory/hosts -l solar
	echo "🌩 Updating nextcloud (password-based)..."
	# Second command: password-based just for nextcloud
	ansible-playbook playbooks/apt.yml -i inventory/hosts --ask-pass --ask-become-pass -l nextcloud

	cd $oldpwd
end

