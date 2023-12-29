# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Golang
export GOROOT=/usr/local/go
export GOPATH=~/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Java and Maven (may need to re-check and tweak this on every install) 
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export MAVEN_HOME=/usr/share/maven

# Add private bin to PATH
export PATH=$PATH:$HOME/.local/bin

# Locale
export LANG=en_US.UTF-8 
export LC_ALL=en_US.UTF-8
