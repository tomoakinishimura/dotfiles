# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias be='bundle exec'
alias railss='rails server -b 0.0.0.0'
alias rubocopdiff='rubocop $( git diff --name-only --diff-filter=AMRC | grep -e ".*\.rb" | paste -s - )'

# Git
function branch() {
  git checkout -b $1;
  git commit --allow-empty -m "CreatePR";
  git push origin $1;
}
source /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash
