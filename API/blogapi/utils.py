

class retMsg:
    def __init__(self, data=[], code=200, msg='success message'):
        self._data = data
        self.retCode = code
        self.retMsg = msg

    def update(self, data=None, code=None, msg=None):
        if data is not None:
            self._data = data
        if code is not None:
            self.retCode = code
        if msg is not None:
            self.retMsg = msg

    def addField(self, name, value):
        self.__dict__[name] = value

    @property
    def data(self):
        body = self.__dict__
        body['data'] = body.pop('_data')
        return body

    @property
    def isEmpty(self):
        return not bool(self._data)

    @property
    def code(self):
        return self.retCode
