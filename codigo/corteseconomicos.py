memo = {}

def ce(i, j, C):
    if (i, j) in memo:
        return memo[(i,j)]
    
    res = []
    if not C:
        return 0
    
    for c in C:
        if i <= c < j:
            s1 = ce(i, c, [k for k in C if i <= k < c])
            s2 = ce(c, j, [k for k in C if c < k < j])
            res.append(s1+s2+(j-i))

    memo[(i,j)] = min(res)
    return memo[(i,j)]


print(ce(0, 10, [2, 4, 7]))
