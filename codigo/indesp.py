def indiceEspejo(A,low,high):

    mid = low + (high-low) //2 #O(1)

    if A[mid] == mid: #O(1)
        return mid
    elif len(A) == 1: #O(1)
        return -1
    
    elif A[mid] < mid:
        return indiceEspejo(A,mid+1,high) #a=1,c=2
    elif A[mid] > mid:
        return indiceEspejo(A,low,mid-1) #a=1,c=2