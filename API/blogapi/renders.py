# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import json

from django.http.multipartparser import parse_header
from django.utils import six

from rest_framework.settings import api_settings
from rest_framework.utils import encoders
from rest_framework.compat import (
    INDENT_SEPARATORS, LONG_SEPARATORS, SHORT_SEPARATORS
)


def zero_as_none(value):
    return None if value == 0 else value


class BaseRenderer(object):
    """
    All renderers should extend this class, setting the `media_type`
    and `format` attributes, and override the `.render()` method.
    """
    media_type = None
    format = None
    charset = 'utf-8'
    render_style = 'text'

    def render(self, data, accepted_media_type=None, renderer_context=None):
        msg = 'Renderer class requires .render() to be implemented'
        raise NotImplementedError(msg)


class JSONRenderer(BaseRenderer):
    """
    Renderer which serializes to JSON.
    """
    media_type = 'application/json'
    format = 'json'
    encoder_class = encoders.JSONEncoder
    ensure_ascii = not api_settings.UNICODE_JSON
    compact = api_settings.COMPACT_JSON

    # We don't set a charset because JSON is a binary encoding,
    # that can be encoded as utf-8, utf-16 or utf-32.
    # See: http://www.ietf.org/rfc/rfc4627.txt
    # Also:
    # http://lucumr.pocoo.org/2013/7/19/application-mimetypes-and-encodings/
    # in source code charset was set to None, change it to utf-8
    charset = 'utf-8'

    def get_indent(self, accepted_media_type, renderer_context):
        if accepted_media_type:
            # If the media type looks like 'application/json; indent=4',
            # then pretty print the result.
            # Note that we coerce `indent=0` into `indent=None`.
            base_media_type, params = parse_header(accepted_media_type.
                                                   encode('ascii'))
            try:
                return zero_as_none(max(min(int(params['indent']), 8), 0))
            except (KeyError, ValueError, TypeError):
                pass

        # If 'indent' is provided in the context, then pretty print the result.
        # E.g. If we're being called by the BrowsableAPIRenderer.
        return renderer_context.get('indent', None)

    def render(self, data, accepted_media_type=None, renderer_context=None):
        """
        Render `data` into JSON, returning a bytestring.
        """
        if data is None:
            return bytes()

        renderer_context = renderer_context or {}
        indent = self.get_indent(accepted_media_type, renderer_context)

        if indent is None:
            separators = SHORT_SEPARATORS if self.compact else LONG_SEPARATORS
        else:
            separators = INDENT_SEPARATORS

        ret = json.dumps(
            data, cls=self.encoder_class,
            indent=indent, ensure_ascii=self.ensure_ascii,
            separators=separators
        )

        # On python 2.x json.dumps() returns bytestrings if ensure_ascii=True,
        # but if ensure_ascii=False, the return type is underspecified,
        # and may (or may not) be unicode.
        # On python 3.x json.dumps() returns unicode strings.
        if isinstance(ret, six.text_type):
            # We always fully escape \u2028 and \u2029 to ensure we output JSON
            # that is a strict javascript subset. If bytes were returned
            # by json.dumps() then we don't have these characters in any case.
            # See: http://timelessrepo.com/json-isnt-a-javascript-subset
            ret = ret.replace('\u2028', '\\u2028').replace('\u2029', '\\u2029')
            return bytes(ret.encode('utf-8'))
        return ret
