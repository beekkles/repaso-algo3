
visitado = []
cola = []

def BFS(G,s):
    visitado.append(s)
    cola.append(s)

    while cola != []:
        u = cola.pop(0)

        for v in G[u]:
            if v not in visitado:
                visitado.append(v)
                cola.append(v)