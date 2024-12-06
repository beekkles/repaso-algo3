memo = {}
w = [19, 7, 5, 6, 1]
s = [15, 13, 7, 8, 2]

res = 0

def PC(i,P):
    if i >= len(w):
        return 0  
    if (i,P) in memo:
        return memo[(i,P)]
    
    res = PC(i+1,P)
    
    if P+w[i] <= s[i]:
        res = max(res, 1 + PC(i+1, P + w[i]))

    memo[(i,P)] = res

    return res

print(PC(0, 0)) 
