{gpgKey}: ''
  [user]
  	name = kinzoku-dev
  	email = kinzoku@the-nebula.xyz
    signingkey = ${gpgKey}
  [safe]
    directory = *
  [pull]
  	rebase = true
  [init]
  	defaultBranch = main
  [commit]
    gpgsign = true
''
# [gpg]
#     format = ssh

