import inspect
import sys


def die(msg=None):
    f = inspect.currentframe().f_back
    loc = f"{f.f_code.co_filename}:{f.f_lineno}"
    sys.exit(f"{loc}:{msg}" if msg else loc)
