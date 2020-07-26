function javaenv --description 'Create and set a JAVA_HOME environment variable'
    if test (count $argv) -eq 0
        /usr/libexec/java_home -V
    else
        switch $argv[1]
        case 'ls'
            /usr/libexec/java_home -V
        case 'set'
            set -xU JAVA_HOME (/usr/libexec/java_home -v $argv[2])
            set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths
        end
    end
end
