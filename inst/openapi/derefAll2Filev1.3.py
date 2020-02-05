
import yaml
import sys

def dereferenceAll(obj, parent):
    try:
        if type(obj) is dict:
            for fieldStr in obj:
                #print(fieldStr)
                if(fieldStr == '$ref'):
                    refPath = obj[fieldStr].split('/')
                    refObj = parent
                    for refPart in refPath:
                        if refPart in refObj:
                            refObj = refObj[refPart]
                    refObj = dereferenceAll(refObj, parent)
                    refObj['title'] = refPath[-1]
                    obj = {**obj, **refObj}
                elif(fieldStr == 'allOf'):
                    comboObj = {'properties': {}}
                    for item in obj[fieldStr]:
                        itemObj = dereferenceAll(item, parent)
                        comboObj['properties'] = {**(comboObj['properties']), **(itemObj['properties'])}
                    obj = comboObj
                else:
                    obj[fieldStr] = dereferenceAll(obj[fieldStr], parent)
            if '$ref' in obj:
                obj.pop('$ref')
        elif type(obj) is list:
            newList = []
            for item in obj:
                newList.append(dereferenceAll(item, parent))
            obj = newList
    except:
        print(obj)
    return obj

def dereferenceBrAPI(filePath = './brapi_openapi.yaml'):    
    fileObj = {}
    print(filePath)
    with open(filePath, "r") as stream:
        try:
            fileObj = yaml.load(stream)
        except yaml.YAMLError as exc:
            print(exc)
    
    fileObj = dereferenceAll(fileObj, fileObj)
    return fileObj;

def str_presenter(dumper, data):
  if len(data.splitlines()) > 1:  # check for multiline string
    return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')
  return dumper.represent_scalar('tag:yaml.org,2002:str', data)

yaml.add_representer(str, str_presenter)
noalias_dumper = yaml.dumper.SafeDumper
noalias_dumper.ignore_aliases = lambda self, data: True
if len(sys.argv) > 2 :
    inFilePath = sys.argv[1]
    outFilePath = sys.argv[2]
    print(inFilePath)
    print(outFilePath)
    out = dereferenceBrAPI(inFilePath)
    out.pop('components')
    with open(outFilePath, 'w') as outfile:
        yaml.dump(out, outfile, default_flow_style=False, width=float("inf"), Dumper=noalias_dumper)
