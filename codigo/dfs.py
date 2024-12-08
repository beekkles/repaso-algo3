from queue import LifoQueue

visitado = []
pila = LifoQueue()

def dfs(G,s):
    pila.put(s)

    while not pila.empty():
        u = pila.get()

        if u not in visitado:
            visitado.append(u)

            for v in G[u]:
                if v not in visitado:
                    pila.put(v)