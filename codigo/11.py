v = [0,3,1,5,2,1]
n = len(v)-1
C = ""
memo = {}
def os(i,w,C):
    if (i,w) in memo:
        return memo[(i,w)]
    
    if len(C) == n-1 and w != v[i]:
        return ""
    
    if len(C) == n-1 and w == v[i]:
        return C
    
    res1 = os(i-1,w-v[i],C + "+")
    res2 = os(i-1,w/v[i],C + "x")
    res3 = os(i-1,w**(1/v[i]),C + "↑")

    if res1:
        memo[(i,w)] = res1
    elif res2:
        memo[(i,w)] = res2
    elif res3:
        memo[(i,w)] = res3
    else:
        memo[(i,w)] = ""

    return memo[(i,w)]
    
def os_res(i,w,C):
    return os(i,w,C)[::-1]

print(os_res(n,400,C))