p = [0,3, 6, 10]
n = len(p)-1

memo = [[None for _ in range(n+1)] for _ in range(n+1)]

def at(j, c):
    if memo[j][c] != None:
        return memo[j][c]
    
    if c < 0 or c > j:
        return float('-inf')

    if j == 0 and c == 0:
        return 0
    
    memo[j][c] = max(
                at(j - 1, c - 1) - p[j],
                at(j - 1, c + 1) + p[j],
                at(j - 1, c)
            )
    
    return memo[j][c]

p = [0,3, 6, 10]
n = len(p)-1

memo = [[None for _ in range(n+1)] for _ in range(n+1)]

def atbt(p):
    memo[0][0] = 0

    for j in range(1, n+1):
        for c in range(0, j+1):
            if c < 0 or c > j:
                memo[j][c] = float('-inf')
            else:
                v1 = memo[j-1][c-1] if c-1 >= 0 else float('-inf')
                v2 = memo[j-1][c+1] if c+1 <= j-1 else float('-inf')
                v3 = memo[j-1][c]   if memo[j-1][c] else float('-inf')

                memo[j][c] = max(v1-p[j], v2+p[j], v3)

    return memo[n][0]

print(atbt(p))