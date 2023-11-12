{sshKeyPath}: ''
  [user]
  	name = kinzoku-dev
  	email = kinzokudev4869@gmail.com
      signingkey = ${sshKeyPath}
  [pull]
  	rebase = true
  [init]
  	defaultBranch = main
  [gpg]
      format = ssh
  [commit]
    gpgsign = true
''
