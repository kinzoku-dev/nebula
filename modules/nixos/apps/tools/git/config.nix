{sshKeyPath}: ''
  [user]
  	name = kinzoku-dev
  	email = kinzoku@the-nebula.xyz
    signingkey = ${sshKeyPath}
  [safe]
    directory = *
  [pull]
  	rebase = true
  [init]
  	defaultBranch = main
  [gpg]
      format = ssh
  [commit]
    gpgsign = true
''
