m() {
    case $1 in
        -a )
            if [ $# -eq 1 ]; then
                >&2 echo "Too few arguments"
            else
                local dir
                if [ $# -eq 3 ]; then
                    dir="$3"
                else
                    dir="$(pwd)"
                fi
                git config --global --add mdaj."$2" "$dir"
            fi
            ;;
        -l )
            git config --global --get-regexp 'mdaj.*' | \
                cut -c 6- # remove common prefix
            ;;
        -d )
            git config --global --unset mdaj."$1"
            ;;
        * )
            if [ $# -eq 0 ]; then
                >&2 echo "Too few arguments"
            else
                local dst
                dst="$(git config --global --get mdaj."$1")"
                if [ $? -eq 0 ]; then
                    cd "$dst"
                else
                    >&2 echo "Mark $1 not found"
                fi
            fi
            ;;
    esac
}
