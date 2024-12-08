def idom(A):
    high = len(A)
    low = 0
    mid = high//2

    if high-1 == low:
        return True

    sumaizq = sum(A[low:mid])
    sumader = sum(A[mid:high])

    if sumaizq > sumader:
        return idom(A[low:mid]) and idom(A[mid:high])
    else:
        return False
    
print(idom([9,8,7,9,5,4,3,2]))