#!/data/data/com.termux/files/usr/bin/python3
import os, sys, json, urllib.request
kp=os.path.expanduser("~/.config/gemini/key")
k=open(kp).read().strip() if os.path.exists(kp) else ""
if not k:
    print("SEM KEY"); sys.exit(1)
q=" ".join(sys.argv[1:])
if len(sys.argv)>1 and sys.argv[1] in ["pro","flash"]:
    q=" ".join(sys.argv[2:])
    m="gemini-pro-latest" if sys.argv[1]=="pro" else "gemini-flash-latest"
else:
    m="gemini-flash-latest"
if not sys.stdin.isatty():
    q=sys.stdin.read()[:80000]+"\n\n"+q
if not q:
    print('Uso: gemini "pergunta"'); sys.exit(0)
url=f"https://generativelanguage.googleapis.com/v1beta/models/{m}:generateContent"
data={"contents":[{"parts":[{"text":q}]}]}
headers={"Content-Type":"application/json", "X-goog-api-key": k}
req=urllib.request.Request(url, data=json.dumps(data).encode(), headers=headers)
try:
    with urllib.request.urlopen(req) as r:
        j=json.loads(r.read())
        print(j["candidates"][0]["content"]["parts"][0]["text"])
except Exception as e:
    try: print(e.read().decode()[:2000])
    except: print(e)
