import sys, json 

x=json.load(sys.stdin) 

# print(x)
# exit

f = x['format']

v = []

for i in x['streams']:
    if i['codec_type'] == 'video':
        v = i

a = []
for i in x['streams']:
    if i['codec_type'] == 'audio':
        a = i


print(v['width'], 'x', v['height'], '\t', round((float)(v['duration'])/60), 'min', '\t', round((float)(f['size'])/1024/1024), 'Mb', '\t', f['filename'])