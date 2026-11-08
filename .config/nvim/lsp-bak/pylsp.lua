return {
    cmd = { 'pylsp', '-vvv', '--log-file', '/tmp/pylsp.log' },
    filetypes = { 'python' },
    settings = {
        pylsp = {
            plugins = {
                ruff = { enabled = true },
                mypy = { enabled = true },
                black = { enabled = true },
            },
        },
    },

    root_markers = { '.git', { 'main.py', '__init__.py', 'requirements.txt' } },
}
