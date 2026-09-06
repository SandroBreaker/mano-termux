#!/data/data/com.termux/files/usr/bin/python3
import os, sys, json, urllib.request, subprocess, pathlib, re
kp=os.path.expanduser("~/.config/gemini/key")
k=open(kp).read().strip() if os.path.exists(kp) else ""
if not k: print("SEM KEY"); sys.exit(1)
q=" ".join(sys.argv[1:]) if len(sys.argv)>1 else ""
if not sys.stdin.isatty(): q=sys.stdin.read()[:100000]+"\n\n"+q
if not q: print('Uso: gemini-agent "faca X"'); sys.exit(0)
TD='Voce e agente Termux. Use JSON: {"action":"read","path":"..."} {"action":"write","path":"...","content":"..."} {"action":"ls","path":"..."} {"action":"sh","cmd":"..."}'
model="gemini-flash-latest"
url=f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent"
hist=f"{TD}\n\nPedido: {q}\n"
for _ in range(8):
    data={"contents":[{"parts":[{"text":hist}]}]}
    headers={"Content-Type":"application/json", "X-goog-api-key": k}
    req=urllib.request.Request(url, data=json.dumps(data).encode(), headers=headers)
    try:
        with urllib.request.urlopen(req) as r:
            j=json.loads(r.read())
            ans=j["candidates"][0]["content"]["parts"][0]["text"]
            print(ans)
            mm=re.search(r'\{.*?"action".*?\}', ans, re.DOTALL)
            if not mm: break
            act=json.loads(mm.group(0))
            if act["action"]=="read":
                txt=pathlib.Path(act["path"]).expanduser().read_text()[:20000]
                hist+=f"\n[TOOL read {act['path']}]:\n{txt}\n"
            elif act["action"]=="write":
                p=pathlib.Path(act["path"]).expanduser(); p.parent.mkdir(parents=True, exist_ok=True); p.write_text(act["content"]); hist+=f"\n[TOOL write OK]\n"
            elif act["action"]=="ls":
                out=subprocess.getoutput(f'ls -la {act["path"]} 2>&1 | head -100'); hist+=f"\n[TOOL ls]:\n{out}\n"
            elif act["action"]=="sh":
                out=subprocess.getoutput(act["cmd"]+" 2>&1 | head -200"); hist+=f"\n[TOOL sh]:\n{out}\n"
            else: break
    except Exception as e:
        try: print(e.read().decode()[:2000])
        except: print(e)
        break
