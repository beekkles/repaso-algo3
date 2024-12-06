A=[
    [0,0,0,0],
    [0,-2,-3,3],
    [0,-5,-10,1],
    [0,10,30,-5]]

n = len(A[0])-1
m = len(A)-1

memo = {}

def TV(i, j):
    if (i,j) in memo:
        return memo[(i,j)]
    
    if i == n and j == m:
        memo[(i,j)] = TVmax(1-A[i][j])
        return memo[(i,j)]

    if i == n:
        memo[(i,j)] = TVmax(TV(i,j+1) - A[i][j])
        return memo[(i,j)]
    
    if j == m:
        memo[(i,j)] = TVmax(TV(i+1,j) - A[i][j])
        return memo[(i,j)]
    
    memo[(i,j)] = TVmax(min(TV(i+1,j), TV(i,j+1)) - A[i][j])
    return memo[(i,j)]

def TVmax(f):
    return max(1,f)
    
print(TV(1,1))