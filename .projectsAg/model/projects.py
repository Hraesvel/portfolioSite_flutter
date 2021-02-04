import json

from typing import cast


class Base:
    priority: int = 0
    name: str = None
    link: str = ""
    description: str = ""
    achievements: list = []
    tech: list = []
    bucket: str = ""
    image: str = ""

    def __init__(self, **kwargs):
        if not kwargs:
            pass
        for k, v in kwargs.items():
            try:
                if k not in ["tech", "achievements"]:
                    if k == 'priority':
                        self.__setattr__(k, int(v))
                    else:
                        self.__setattr__(k, v.strip())
                else:
                    self.__setattr__(k, list(i.strip() for i in v.split('\n')))
            except KeyError as e:
                if k == "type":
                    pass
                else:
                    print(e)

    def toJson(self, removeType=True) -> str:
        encoder = json.JSONEncoder()
        json_string = encoder.encode(self.toDict(removeType=removeType))
        return json_string

    def toDict(self, removeType=True, removeShow=True) -> dict:
        d = self.__dict__
        if removeType:
            d.pop('type', None)
        if removeShow:
            d.pop('show', None)

        return d


class Frontend(Base):
    pass


class Backend(Base):
    pass
