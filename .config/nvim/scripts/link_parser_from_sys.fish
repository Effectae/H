#!/usr/bin/fish

set LOCAL_PARSER_DIR "$HOME/.config/nvim/parser"
set SYS_TREE_SITTER_SUFFIX '/usr/lib64/libtree-sitter-'
set SYS_TREE_SITTER_SUFFIX_LEN $(string length $SYS_TREE_SITTER_SUFFIX)
set CONVERT_TO_LOCAL_SUB_POS $(math 1 + $SYS_TREE_SITTER_SUFFIX_LEN )

set SYS_TREE_SITTERS $SYS_TREE_SITTER_SUFFIX*.so

for SYS_TREE_SITTER in $SYS_TREE_SITTERS
    set TREE_SITTER_BASENAME $(string sub -s $CONVERT_TO_LOCAL_SUB_POS $SYS_TREE_SITTER )

    set TARGET "$LOCAL_PARSER_DIR/$TREE_SITTER_BASENAME"
    if not test -e $TARGET
        echo "Link $SYS_TREE_SITTER to $TARGET"
        ln -rs "$SYS_TREE_SITTER" "$TARGET"
    else
        echo "$TARGET existed"
    end
end
