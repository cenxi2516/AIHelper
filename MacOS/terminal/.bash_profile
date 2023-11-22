# bin环境
export UBIN=/usr/bin
export LBIN=/usr/local/bin:/usr/local/sbin

# moonbit环境
export MOON_HOME="/Users/lishunxiang/.moon/bin"

# brew环境
export HOMEBREW=/opt/homebrew/bin
export BREW_LIB=/opt/homebrew/lib
export BREW_SHARE=/opt/homebrew/share

# brew镜像源
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"

# 关闭brew自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_AUTO_UPDATE=1

# Myself环境
export MYSELF_HOME="$HOME/Myself"

# qv2ray_core环境
export Qv2rayCorePath="$MYSELF_HOME/qv2ray_core"
export BackupPath="$MYSELF_HOME/backup"

# node_cache
export NODE_CACHE="$BREW_LIB/node_cache"

# nvm环境
export NVM_DIR="$HOME/.nvm"
# 加载nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# 加载nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# rvm环境
export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# jdk环境
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH:.
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.

# python环境
export PYTHON_PATH="$HOMEBREW/python3"

# 测试路径
export TEST_PATH="$MYSELF_HOME/test"
export SCRIPT_PATH="$MYSELF_HOME/scripts"

# 写入环境变量
export PATH=$HOMEBREW:$BREW_LIB:$BREW_SHARE:$UBIN:$LBIN:$MYSELF_HOME:$MOON_HOME:$PYTHON_PATH:$PATH

# 编码
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# OpenAI
# API Key
export OpenAI_API_KEY="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";
export OpenAI_OutputFile="$SCRIPT_PATH/TerminalAIChat/gptChatCache.json";
