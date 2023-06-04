def GetKeyValue(InputObject, InputKey):
    keys = InputKey.split('/')
    # print(keys)
    Outvalue = InputObject
    # print(Outvalue)
    try:
      for key in keys:
        Outvalue = Outvalue[key]
        # print(key)
        # print(Outvalue)
      return Outvalue
    except KeyError:
       return None


InputObject1 = {"a":{"b":{"c":"d"}}}
InputKey1 = "a/b/c" 

result = GetKeyValue(InputObject1, InputKey1)
print(result)


InputObject2 = {"x":{"y":{"z":"a"}}}
InputKey2 = "x/y/z"

result1 = GetKeyValue(InputObject2, InputKey2)
print(result1)