return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--query-driver=**/gcc,**/g++,**/clang,**/clang++',
    },
    filetypes = { 'c', 'cpp' },
    root_markers = { '.git', { 'build/compile_commands.json', 'compile_commands.json' } },
}
