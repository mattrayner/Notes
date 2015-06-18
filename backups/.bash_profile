alias ll="ls -lahG"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt" # Load our custom bash prompt

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s ~/.bashrc ]] && source ~/.bashrc

##
# Your previous /Users/matthew.rayner/.bash_profile file was backed up as /Users/matthew.rayner/.bash_profile.macports-saved_2014-01-15_at_14:28:47
##

# MacPorts Installer addition on 2014-01-15_at_14:28:47: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/matt/.bash_profile file was backed up as /Users/matt/.bash_profile.macports-saved_2014-03-02_at_23:16:28
##

# MacPorts Installer addition on 2014-03-02_at_23:16:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/matthewrayner/.bash_profile file was backed up as /Users/matthewrayner/.bash_profile.macports-saved_2014-03-20_at_17:23:21
##

# MacPorts Installer addition on 2014-03-20_at_17:23:21: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home'
export PATH=$PATH:$JAVA_HOME
