def aparece(A,i,j,e):
    for k in range (i,j+1):
        if A[k] == e:
            return True
    return False

def ubicar(A,e,low,high):
    
    mid = low + (high-low) // 2 #O(1)
    if len(A) == 1 and e not in A: #O(1)
        return False
    if A[mid] == e: #O(1)
        return True
    
    if aparece(A,low,mid,e): #O(raiz(mid-low+1)) = O(raiz(n/2))
        return ubicar(A,e,low,mid)
    else:
        return ubicar(A,e,mid+1,high)
