
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight

function strip_diff_leading_symbols(){
    color_code_regex=$'(\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])'

        # simplify the unified patch diff header
        sed -E "s/^($color_code_regex)diff --git .*$//g" | \
               sed -E "s/^($color_code_regex)index .*$/\
\1$(rule)/g" | \
               sed -E "s/^($color_code_regex)\+\+\+(.*)$/\1\+\+\+\5\\
\1$(rule)/g" | \

        # actually strips the leading symbols
               sed -E "s/^($color_code_regex)[\+\-]/\1 /g"
}

## Print a horizontal rule
rule () {
        printf "%$(tput cols)s\n"|tr " " "─"
}
