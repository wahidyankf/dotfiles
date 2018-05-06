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

# PERSONAL

# First level
yk_path_online_repos=~/0_onlineRepos/
yk_path_dropbox=~/Dropbox/

yk_path_zshrc=~/.zshrc

# # Second level
yk_path_learn=$yk_path_online_repos"2_learn/"
yk_path_writing=$yk_path_online_repos"0_writing/"
yk_path_portfolio=$yk_path_online_repos"1_portfolio/"

yk_path_0_code=$yk_path_dropbox"0_code/"
yk_path_backup_online_repos=$yk_path_dropbox"0_backup_onlineRepos/"

# # # Third level
yk_path_ayokoding=$yk_path_writing"ayokoding/"
yk_path_dot_files=$yk_path_0_code"a_dotfiles/"

function yk_cd_onlinerepos {
  builtin cd $yk_path_online_repos
}

function yk_cd_learn {
  builtin cd $yk_path_learn
}

function yk_cd_ayokoding {
  builtin cd $yk_path_ayokoding
}

function yk_cd_port {
  builtin cd $yk_path_portfolio
}

function yk_cd_dot {
  builtin cd $yk_path_dot_files
}

function yk_dotdeploy {
  cwd=$(pwd)
  yk_cd_dot && npm run deploy && builtin cd $cwd
}

function yk_backuprepo {
  cwd=$(pwd)
  builtin cd ~ && rsync -avz --progress --exclude-from '.rsyncexclude' $yk_path_online_repos $yk_path_backup_online_repos && builtin cd $cwd
}

function yk_clearbackup {
  rm -rf $yk_path_backup_online_repos
}

function yk_clearandbackuprepo {
  yk_clearbackup && yk_backuprepo
}

function yk_reloadzsh {
  cwd=$(pwd)
  builtin source $yk_path_zshrc && builtin cd $cwd
}

function yk_testcmd {
  cwd=$(pwd)
  yk_reloadzsh && builtin cd $cwd && $1
}

# JOBS - RG

# RG - First level

rg_path=$path_online_repos"0_jobs_ruang_guru/"

# # RG - Second level

rg_path_fe=$rg_path"frontend/"
rg_path_source=$rg_path"source/"

# # RG - Third Level
rg_path_ruker_app=$rg_path_source"ruker-app/"
rg_path_ruker_dashboard=$rg_path_source"ruker-dashboard/"
rg_path_ruker_cms=$rg_path_source"ruker-cms/"
rg_path_shared_lib=$rg_path_source"shared-lib/"

function rg_cd_rg {
 builtin cd $rg_path
}

function rg_cd_fe {
  builtin cd $rg_path_fe
}

function rg_cd_source {
  builtin cd $rg_path_source
}

function rg_cd_rukerapp {
  builtin cd $rg_path_ruker_app
}

function rg_cd_rukerdash {
  builtin cd $rg_path_ruker_dashboard
}

function rg_cd_rukercms {
  builtin cd $rg_path_ruker_cms
}

function rg_cd_sharedlibs {
  builtin cd $rg_path_shared_lib
}

# RG - Ruker App - Utils

function rg_rniosgoto {
  xcrun simctl openurl booted ruangkerja://$1
}

function rg_rniosgoto2 {
  rg_rniosgoto $1 && rg_rniosgoto $2
}

function rg_rniosstartgoto {
  yarn run-ios && rg_rniosgoto $1
}

function rg_rnandroidgoto {
  adb shell am start -W -a android.intent.action.VIEW -d "ruangkerja://ruangkerja/$1" com.ruangguru.kerjaStaging
}

function rg_rnandroidgoto2 {
  rg_rnandroidgoto $1 && rg_rnandroidgoto $2
}

function rg_rnandroidstartgoto {
  yarn run-android && rg_rnandroidgoto $1
}

function rg_rndebugger {
  open "rndebugger://set-debugger-loc?host=localhost&port=8081"  
}

function rg_rniosdevpretestview {
  rg_rniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123
}

function rg_rniosdevpretestresult {
  rg_rniosgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && rg_rniosgoto test-result/course12311/pretest/course12311-pretest123 
}

function rg_rniosdevpretestresult0 {
  rg_rniosgoto test-result/course12311/pretest/course12311-pretest123 
}

function rg_rniosdevposttestview {
  rg_rniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123
}

function rg_rniosdevposttestresult {
  rg_rniosgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && rg_rniosgoto test-result/course12311/posttest/course12311-posttest123 
}

function rg_rniosdevposttestresult0 {
  rg_rniosgoto test-result/course12311/posttest/course12311-posttest123 
}

function rg_rnandroiddevpretestview {
  rg_rnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123
}

function rg_rnandroiddevpretestresult {
  rg_rnandroidgoto2 course-detail/course12311 test/course12311/pretest/course12311-pretest123 && rg_rnandroidgoto test-result/course12311/pretest/course12311-pretest123 
}

function rg_rnandroiddevpretestresult0 {
  rg_rnandroidgoto test-result/course12311/pretest/course12311-pretest123 
}

function rg_rnandroiddevposttestview {
  rg_rnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123
}

function rg_rnandroiddevposttestresult {
  rg_rnandroidgoto2 course-detail/course12311 test/course12311/posttest/course12311-posttest123 && rg_rnandroidgoto test-result/course12311/posttest/course12311-posttest123 
}

function rg_rnandroiddevposttestresult0 {
  rg_rnandroidgoto test-result/course12311/posttest/course12311-posttest123 
}

function rg_rniosdevcoursedetail {
  rg_rniosgoto course-detail/course12311
}

function rg_rniosdevcoursepreview {
  rg_rniosgoto course-preview/course1231
}

function rg_rnandroiddevcoursedetail {
  rg_rnandroidgoto course-detail/course12311
}

function rg_rnandroiddevcoursepreview {
  rg_rnandroidgoto course-preview/course1231
}

