A = [
    [0, 0, 0, 0],
    [0, -2, -3, 3],
    [0, -5, -10, 1],
    [0, 10, 30, -5]
]

n = len(A)-1
m = len(A[0])-1

memo = [[float('inf')] * (m+1) for _ in range(n+1)]

def TV(i, j):
    memo[n][m] = TVmax(1-A[n][m])

    for i in range(n-1, -1, -1):
        memo[i][m] = TVmax(memo[i+1][m] - A[i][m])

    for j in range(m-1, -1, -1):
        memo[n][j] = TVmax(memo[n][j+1] - A[n][j])

    for i in range(n-1, -1, -1):
        for j in range(m-1, -1, -1):
            memo[i][j] = TVmax(min(memo[i+1][j], memo[i][j+1]) - A[i][j])

    return memo[1][1]

def TVmax(f):
    return max(1,f)

print(TV(1, 1))
