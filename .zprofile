
for p in "$HOME/.bin" "/snap/bin" "$HOME/arduino" "$HOME/.cargo/bin"; do
    [ -e $p ] && P="$p:$P"
done

[ -n $P ] && export PATH="$P$PATH"
