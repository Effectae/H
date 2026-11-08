white_list = {
    # "Tag" : [ Path1,
    #   ("path_prefix(optional)",
    #        ["Part to composo","Part1",...],"path_suffix(optional)"),
    #  ...]
    # tip:
    "conf": [
        (".config/", ["pipewire", "tmux", "nvim", "fish", "foot"], "/**"),
        (".git", ["config", "hub-proxy-config"]),
        (".bash", ["_profile", "rc"]),
        ".cargo/config.toml",
    ],
    "notes": ["notes/**"],
    "retain": ["retain/**"],
}


from copy import deepcopy

from die import die


def _expr_tuple_compose(it, string: str = ""):
    while True:
        try:
            elem = next(it)
        except StopIteration:
            yield string
            break
        match elem:
            case str():
                string += elem
            case list():
                for s in elem:
                    yield from _expr_tuple_compose(deepcopy(it), string + s)
                break
            case _ as bad:
                raise SyntaxError(f"Unexpected {type(bad).__name__}: {bad!r}")


def white_list_path():
    values = white_list.values()
    for expr_arr in values:
        for path_expr in expr_arr:
            match path_expr:
                case str():
                    yield path_expr
                case tuple():
                    yield from _expr_tuple_compose(iter(path_expr))
                case _:
                    die(f"Unknow expression:{path_expr}")
