# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/abdurrahman/.oh-my-zsh
export PATH=/Users/abdurrahman/anaconda3/bin:$PATH
export EDITOR=vim
export DISABLE_AUTO_TITLE=true
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cloud"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
cd ~

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abdurrahman/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/abdurrahman/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abdurrahman/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/abdurrahman/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/opt/python/libexec/bin:$PATH"  

tmux

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Functions - Personal

function ykcdonlinerepos {
  builtin cd ~/0_onlineRepos/
}

function ykcdlearn {
  ykcdonlinerepos && builtin cd 2_learn/
}

function ykcdayokoding {
  ykcdonlinerepos && builtin cd 0_writing/ayokoding/
}

function ykcdport {
  ykcdonlinerepos && builtin cd 1_portfolio/
}

function ykcddot {
  builtin cd ~/Dropbox/0_code/a_dotfiles/
}

function ykcddotdeploy {
  cwd=$(pwd)
  ykcddot && npm run deploy && builtin cd $cwd
}

function ykbackuprepo {
  cwd=$(pwd)
  builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' ~/0_onlineRepos/ ~/Dropbox/0_backup_onlineRepos/ && builtin cd $cwd
}

function ykclearbackup {
  rm -rf ~/Dropbox/0_backup_onlineRepos/
}

function ykclearandbackuprepo {
  cwd=$(pwd)
  ykclearbackup && builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' ~/0_onlineRepos/ ~/Dropbox/0_backup_onlineRepos/ && builtin cd $cwd
}

function ykreloadzsh {
  cwd=$(pwd)
  builtin source ~/.zshrc && builtin cd $cwd
}

# Functions - jobs

function ykrgcdrg {
 ykrgcdonlinerepos && builtin cd 0_jobs_ruang_guru/
}

function ykrgcdfe {
  ykrgcdonlinerepos && builtin cd 0_jobs_ruang_guru/frontend/
}

function ykrgcdsource {
  ykrgcdonlinerepos && builtin cd 0_jobs_ruang_guru/source
}

function ykrgcdrukerapp {
  ykrgcdsource && builtin cd ruker-app
}

function ykrgcdrukerdash {
  ykrgcdsource && builtin cd ruker-dashboard
}

function ykrgcdrukercms {
  ykrgcdsource && builtin cd ruker-cms
}

function ykrgcdrgsharedlibs {
  ykrgcdsource && builtin cd shared-lib
}

function ykrgrniosgoto {
  xcrun simctl openurl booted ruangkerja://$1
}

function ykrgrniosgoto2 {
  ykrgrniosgoto $1 && ykrgrniosgoto $2
}

function ykrgrniosstartgoto {
  yarn run-ios && ykrgrniosgoto $1
}

function ykrgrnandroidgoto {
  adb shell am start -W -a android.intent.action.VIEW -d "ruangkerja://ruangkerja/$1" com.ruangguru.kerjaStaging
}

function ykrgrnandroidgoto2 {
  ykrgrnandroidgoto $1 && ykrgrnandroidgoto $2
}

function ykrgrnandroidstartgoto {
  yarn run-android && ykrgrnandroidgoto $1
}

function ykrgrndebugger {
  open "rndebugger://set-debugger-loc?host=localhost&port=8081"  
}

function ykrgrniosdevpretestview {
  ykrgrniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123
}

function ykrgrniosdevpretestresult {
  ykrgrniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && ykrgrniosgoto test-result/course12311/pretest/course12311-pretest123 
}

function ykrgrniosdevpretestresult0 {
  ykrgrniosgoto test-result/course12311/pretest/course12311-pretest123 
}

function ykrgrniosdevposttestview {
  ykrgrniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123
}

function ykrgrniosdevposttestresult {
  ykrgrniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && ykrgrniosgoto test-result/course12311/posttest/course12311-posttest123 
}

function ykrgrniosdevposttestresult0 {
  ykrgrniosgoto test-result/course12311/posttest/course12311-posttest123 
}

function ykrgrnandroiddevpretestview {
  ykrgrnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123
}

function ykrgrnandroiddevpretestresult {
  ykrgrnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && ykrgrnandroidgoto test-result/course12311/pretest/course12311-pretest123 
}

function ykrgrnandroiddevpretestresult0 {
  ykrgrnandroidgoto test-result/course12311/pretest/course12311-pretest123 
}

function ykrgrnandroiddevposttestview {
  ykrgrnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123
}

function ykrgrnandroiddevposttestresult {
  ykrgrnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && ykrgrnandroidgoto test-result/course12311/posttest/course12311-posttest123 
}

function ykrgrnandroiddevposttestresult0 {
  ykrgrnandroidgoto test-result/course12311/posttest/course12311-posttest123 
}

function ykrgrniosdevcoursedetail {
  ykrgrniosgoto course-detail/course12311
}

function ykrgrniosdevcoursepreview {
  ykrgrniosgoto course-preview/course1231
}

function ykrgrnandroiddevcoursedetail {
  ykrgrnandroidgoto course-detail/course12311
}

function ykrgrnandroiddevcoursepreview {
  ykrgrnandroidgoto course-preview/course1231
}

