# GitHub Cli

## Links

* Links
  * [GitHub Projekt](https://cli.github.com/)
  * [Documentation](https://cli.github.com/manual/)

## Demo

### gh completion

```powershell
# Shell type: {bash|zsh|fish|powershell}
gh completion --shell powershell

gh completion --shell powershell | out-string | invoke-expression

$profile
new-Item $profile

# gh completion --shell powershell | out-string | invoke-expression kopieren

```

### gh config

```powershell
gh config

gh config get git_protocol

gh config set foo bar
gh config get foo

# set default editor
gh config set editor "code --wait"

cd $env:USERPROFILE/.config/gh
code config.yml
code state.yml
```

### gh version

```powershell
gh version
```

### gh repo

```powershell
# See the four core commands:
cd D:\ghcli\
gh repo --help
```

#### gh repo create

```powershell

gh repo create --help

# demo 1 create a public repo from my account
gh repo create meetup-private

# demo 2 create a private repo from my org
gh repo create whiteducksoftware/meetup-public -d "das ist ein pulbic repository" --public

# demo 3 - create repo from existing directory
mkdir ghcli
'# hello world' | out-file readme.md

git init

gh repo create

git add .
git commit -m "initial commit"
git push origin master

```

#### gh repo clone

```powershell

gh clone cli/cli

```

#### gh repo fork

```powershell

gh repo fork cli/cli
git remote show origin

```

#### gh repo view

```powershell

gh repo view cli/cli --web

```

### gh issue

```powershell

gh repo create issue

gh issue --help

gh issue create

gh issue create --repo mjisaak/community

gh issue list

gh issue list --repo cli/cli
gh issue status

gh issue close 1

gh issue view 1

gh issue repoen 1

```

### gh pr

```powershell
'# hello!'  | out-file readme.md
git add .
git commit -m "markdown"
git push origin master

git checkout -b newbranch


code .\readme.md
# change content to hello, from newbranch!
git add .
git commit -m "changed title"
git push origin newbranch

gh pr create

gh pr list
gh pr view

gh pr diff 2
gh pr merge 2
```
