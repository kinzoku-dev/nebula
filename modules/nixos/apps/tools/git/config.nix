{sshKeyPath}: ''
  [user]
  	name = kinzoku-dev
  	email = kinzoku@the-nebula.xyz
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
# signingkey = 24C05E5FC1A52F45

