class Experiences:
    name = None
    isUTC = True
    start = 0
    end = 0
    isCurrent = False
    headline = None
    description = None
    achievements = []

    def __init__(self, **kwargs):
        if not kwargs:
            print("kwargs is required")
            return
        for (key, value) in kwargs.items():
            try:
                if key == 'achievements':
                    self.achievements = list(filter(lambda v: v != "", value.split("\n")))
                elif key in ['start', 'end']:
                    self.__setattr__(key, int(value))
                elif value in ['TRUE', 'FALSE']:
                    self.__setattr__(key, value == 'TRUE')
                else:
                    self.__setattr__(key, value.strip())
            except KeyError as e:
                if key == 'type':
                    continue
                print(e)

    def toDict(self, removeType=True, removeShow=True) -> dict:
        d = self.__dict__
        if removeType:
            d.pop('type', None)
        if removeShow:
            d.pop('show', None)
        return d
