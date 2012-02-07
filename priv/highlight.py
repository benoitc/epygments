from erlport import Port, Protocol, String
from pygments.lexers import get_all_lexers
import json


def _get_lexers():
    lexers = list(get_all_lexers())
    ret = []
    for l in lexers:
        if l[1][0] != "text":
            ret.append((l[1][0],l[0],))
    ret.sort()
    return [('text', 'Plain text',)] + ret

class HighlightProtocol(Protocol):

    def handle_all_languages(self):
        return _get_lexers()

if __name__ == "__main__":
    proto = HighlightProtocol()
    # Run protocol with port open on STDIO
    proto.run(Port(packet=4, use_stdio=True, compressed=True))

