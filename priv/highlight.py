# -*- coding: utf-8 -
#
# This file is part of epygments available under the public domain or
# MIT license. See the NOTICE for more information.


from erlport import Port, Protocol, String
from pygments import highlight, lexers, formatters
import json

class SimpleFormatter(formatters.HtmlFormatter):
        def wrap(self, source, outfile):
                return self._wrap_code(source)

        def _wrap_code(self, source):
            l = 0
            for i, t in source:
                if i == 1:
                    l += 1
                yield i, t


class HighlightProtocol(Protocol):

    def handle_all_languages(self):
        all_lexers = list(lexers.get_all_lexers())
        ret = []
        for l in all_lexers:
            if l[1][0] != "text":
                ret.append((l[1][0],l[0],))
        ret.sort()
        return [('text', 'Plain text',)] + ret

    def handle_highlight(self, code, lexer_name, formatter_name,
            options):
        try:
            lexer = lexers.get_lexer_by_name(lexer_name)
        except:
            lexer = lexers.get_lexer_by_name('text')


        if formatter_name == "SimpleFormatter":
            formatter_class = SimpleFormatter
        else:
            formatter_class = getattr(formatters, formatter_name)

        formatter = SimpleFormatter(**dict(options))
        return highlight(code, lexer, formatter)


if __name__ == "__main__":
    proto = HighlightProtocol()
    # Run protocol with port open on STDIO
    proto.run(Port(packet=4, use_stdio=True, compressed=True))

