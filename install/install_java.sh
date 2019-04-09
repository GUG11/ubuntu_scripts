# download jdk-${VERSION}_linux-x64_bin.deb
export DOWN_PATH="/home/hyzhang1993/Downloads/software"
sudo dpkg -i "${DOWN_PATH}/jdk-$1_linux-x64_bin.deb"  # will install /usr/lib/jvm/jdk-${VERSION}

echo "updating Debian alternative system"
export JVM_PATH="/usr/lib/jvm/jdk-$1"
sudo update-alternatives --install "/usr/bin/java" "java" "${JVM_PATH}/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "${JVM_PATH}/bin/javac" 1
sudo update-alternatives --install "/usr/bin/jar" "jar" "${JVM_PATH}/bin/jar" 1
sudo update-alternatives --install "/usr/bin/jdb" "jdb" "${JVM_PATH}/bin/jdb" 1

sudo chmod a+x /usr/bin/java
sudo chmod a+x /usr/bin/javac
sudo chmod a+x /usr/bin/jar
sudo chmod a+x /usr/bin/jdb
sudo chown -R root:root ${JVM_PATH}

# optional if there are multiple java implementations
# sudo update-alternatives --config java
# sudo update-alternatives --config javac
# sudo update-alternatives --config javaws
